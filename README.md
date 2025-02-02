# nerdland_publishing_tools
Tools we use to generate chaptered and tagged MP3 files for the Nerdland podcasts. 

These are probably pretty specific to our workflow, but might be useful for other podcasters, especially the chaptering/tagging, which makes our chapters compatible with all major podcast players.

# Process
Full process described in ``process.sh``

The **input** is (take note of the monthYY naming scheme):
* **MP3 file** (eg ``april24.mp3``).
    * We start from an uncompressed WAV file and then compress it as follows using [ffmpeg](https://www.ffmpeg.org/): ``ffmpeg -i inputfile.wav -codec:a libmp3lame -qscale:a 0 output.mp3``
    * V0 is the highest variable bitrate setting of the [LAME MP3 encoder](https://lame.sourceforge.io/).
* **PNG visual** (eg ``april24.png``)
    * Our artwork is 960x960 pixels and usually comes in < 1 Mb, but the MP3 file format supports up to 16 Mb files. 
* Adobe Audition **CSV file** that contains the chapter markers (eg ``april24.csv``).
    * The seperators should be TABs. An example CSV file with chapter markers is provided in ``example.csv``.

The **output** is:
* A chaptered and tagged MP3 file (eg ``april24-chapters.mp3``)
* A TXT file containing chapter markers that are compatible with Spotify or Youtube description fields (eg ``april24.spotify.txt``)
* A HTML file containing a bulleted list with chapter links on SoundCloud (eg ``april24.html``)

# Requirements
* Bash
* Python 3
* [Audition Chapter Tagger](https://github.com/DrSkunk/audition-chapter-tagger)
* [ffmpeg](https://www.ffmpeg.org/) (optional)

