from converter import Converter
from transcriber import Transcriber

#By:JohanS_Z
def main():
  print("Starting converter enjoy!")
  converter = Converter("../input/video.mkv")
  mp3_file = converter.convert()
  
  transcriber = Transcriber(mp3_file)
  transcription = transcriber.transcribe()
  
  
  
  
  
if __name__ == "__main__":
    main()