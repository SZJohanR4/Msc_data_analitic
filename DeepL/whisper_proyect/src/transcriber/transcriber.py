import whisper
import random
import random

class Transcriber():
  def __init__(self, mp3_file:str):
    self.mp3_file = mp3_file

  def transcribe(self):
    """
    Change a mp3 file to txt
    output: ../output/transcription_[CODE].txt
    """
    model = self.load_model()
    audio_transcribe = model["model"].transcribe(self.mp3_file, language="es")
    print(audio_transcribe,"************************")
    with open(model["output_path"], "w") as txt:
      txt.write(audio_transcribe)
    
    return model["output_path"]
    
  def load_model(self):
    try:
      code = self.mp3_file.split("_")[1]
      model = whisper.load_model("base")
      output_path = f"../output/transcription_{code}.txt"
      return {"model": model, "output_path": output_path}
    except Exception as e:
      raise Exception(e)
      