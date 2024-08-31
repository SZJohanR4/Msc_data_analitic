from converter import Converter
from transcriber import Transcriber

#By:JohanS_Z
def main():
  print("Starting converter enjoy!")
  #converter = Converter("../input/video.mkv")
  #mp3_file = converter.convert()
  
  transcriber = Transcriber("../output/video_954083.mp3")
  transcription = transcriber.transcribe()
  
  
  
  
  
if __name__ == "__main__":
    main()