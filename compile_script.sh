# zip -r ../BUILD\?/game.zip ../SRC\?\?/*
# zip -r ./BUILD/game.zip ../SRC/
# zip -r ../BUILD\?/game.zip ../SRC\?\?/*
# zip -r ./BUILD/game.love ./SRC/*   
# zip -r ./BUILD/game.zip ./SRC/*
  
cd ./SRC; zip -r ../BUILD/game.love ./* ; cd .. 
cd ./SRC; zip -r ../BUILD/game.zip ./*  ; cd ..


