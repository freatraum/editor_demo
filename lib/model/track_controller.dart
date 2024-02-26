class TrackController {
  double _gain =0.0;
  double _pan = 0.0;
  bool _solo=false;
  bool _mute=false;

  get gain=>_gain;
  get pan=>_pan;
  get solo=>_solo;
  get mute=>_mute;
  
  setGain(double gain){
    _gain=gain;
  }

  setPan(double pan){
    _pan = pan;
  }

  setSolo(bool solo){
    _solo =solo;
  }

  setMute(bool mute){
    _mute =mute;
  }
}