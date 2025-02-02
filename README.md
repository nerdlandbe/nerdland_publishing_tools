# nerdland_publishing_tools
Tools we use to generate chaptered and tagged MP3 files for the Nerdland podcasts. 

These are probably pretty specific to our workflow, but might be useful for other podcasters, especially the chaptering/tagging, which makes our chapters compatible with all major podcast players.

# Process
Full process described in ``process.sh``

The **input** is:
* MP3 file (eg ``april24.mp3``)
* PNG visual (eg ``april24.png``)
* Adobe Audition CSV file that contains the chapter markers (eg ``april24.csv``). Note: the seperators should be TABs. An example CSV file with chapter markers is provided in ``example.csv``.

The **output** is:
* A chaptered and tagged MP3 file (eg ``april24-chapters.mp3``)
* A TXT file containing chapter markers that are compatible with Spotify or Youtube description fields (eg ``april24.spotify.txt``)
* A HTML file containing a bulleted list with chapter links on SoundCloud (eg ``april24.html``)

# Requirements
* Bash
* Python3
* [Audition Chapter Tagger](https://github.com/DrSkunk/audition-chapter-tagger)

