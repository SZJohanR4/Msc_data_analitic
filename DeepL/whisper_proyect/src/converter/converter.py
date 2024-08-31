import random
from moviepy.editor import VideoFileClip


class Converter():
  def __init__(self, file_path:str):
    self.file_path = file_path

  def convert(self):
    """ 
    Convert video file to audio 
    output: ../output/FILE_NAME.mp3
    """
    try:
      video = VideoFileClip(self.file_path)
      audio_file_name = f"../output/video_{random.randint(0, 1000000)}.mp3"
      video.audio.write_audiofile(audio_file_name)
      return audio_file_name
    except Exception as e:
      raise Exception(e)
    
  