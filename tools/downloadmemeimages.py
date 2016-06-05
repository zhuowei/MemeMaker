#!/usr/bin/python
import json
import subprocess

with open("../MemeMakerKit/memes.json", "r") as infile:
	memes = json.load(infile)["data"]
	for meme in memes:
		subprocess.call("curl " + meme["link"] + " > " + meme["id"] + ".jpg", shell=True)
