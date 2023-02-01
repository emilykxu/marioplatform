class FBridge extends FGameObject {
  
  FBridge(float x, float y){
    super();
    setPosition(x, y);
    attachImage(bridge);
    setStatic(true);
    setName("bridge");
    
  }
  
  void act(){
    if(isTouching("player")){
      setStatic(false);
      setSensor(true);
    
  }
  
  
}
}
