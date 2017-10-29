import os

from flask import Flask, render_template, url_for, request, redirect

import database
import util
from fix_playlist_titles import get_title_from_youtube_url, remove_commas_from_string

TEMPLATE_DIR = os.path.join(util.BASE_PATH, "templates")
INDEX_HTML = 'index.html'

app = Flask(__name__, template_folder=TEMPLATE_DIR)


@app.route("/")
def main():
    return render_template(INDEX_HTML)


def _convert_first_href(line):
    """ This converts the first entry on the line to an a-href """
    x = line.split(',')
    x[0] = '<a href=%(url)s>%(url)s</a>' % {'url': x[0]}
    return ",".join(x)


@app.route('/playlist')
def print_csv():
    """ This prints out the CSV with a header added """
    # read lines, and make the first a link
    show_played = request.args.get('showPlayed', 'true') == 'true'
    show_out_of_office = request.args.get('showOutOfOffice', 'true') == 'true'
    songs = database.load_songs(include_played=show_played, include_out_of_office=show_out_of_office)
    entries = [_convert_first_href(str(x)) for x in songs]
    header_line = "YouTube Link,Played,Song Name,Added by\n"
    return "%s%s" % (header_line, "\n".join(entries))


@app.route('/song_name')
def get_song_name():
    """ This gets the song name from the YouTube address """
    try:
        url = request.args.get('url')
        if url:
            return get_title_from_youtube_url(url)
        else:
            return '<URL was missing>'
    except Exception as ex:
        return str(ex.message)


@app.route("/add-entry/", methods=["POST"])
def add_entry():
    """ Adds an entry to the CSV database, and refreshes the home page to update """
    username = remove_commas_from_string(request.form["name"])
    link = remove_commas_from_string(request.form["ytLink"])
    song = remove_commas_from_string(request.form["songName"])

    with database.connect_to_database() as db:
        user_id = database.get_userid(db, username)
        database.add_song(db, link, song, user_id)

    return redirect(url_for('main'))


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8484)
