import os

from flask import Flask, render_template, send_file, url_for, request, redirect
from main import PLAYLIST_PATH, read_playlist_without_newlines, read_playlist_lines, get_title_from_youtube_url
from main import playlist_line_has_been_played, remove_commas_from_string

PLAYLIST_NAME = os.path.basename(PLAYLIST_PATH)

app = Flask(__name__)


@app.route("/")
def main():
    return render_template('index.html')


@app.route('/playlist.csv')
def plot_csv():
    """ This downloads the original file as a CSV """
    return send_file(PLAYLIST_PATH,
                     mimetype='text/csv',
                     attachment_filename=PLAYLIST_NAME,
                     as_attachment=True)


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
    if show_played:
        entries = [_convert_first_href(x) for x in read_playlist_lines()]
    else:
        # this will only show those that have not been played
        entries = [_convert_first_href(x) for x in read_playlist_lines() if not playlist_line_has_been_played(x)]
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

    # playlist data
    f_playlist = read_playlist_without_newlines()

    # open read/write, so that we can make sure no new lines are created
    with open(PLAYLIST_PATH, 'w') as f:
        # the new line to be written
        new_line = ",".join([link, str(False), song, username])

        # write out the file with a new line (if it existed, else just the new line)
        if f_playlist:
            f.write("%s\n%s" % (f_playlist, new_line))
        else:
            f.write("%s" % new_line)

    return redirect(url_for('main'))


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8484)
