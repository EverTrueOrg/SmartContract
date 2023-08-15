## Introduction

We know that economic models represent the flow and distribution of benefits, and people recognize benefits as valuable for two reasons, either because they generate money or because they satisfy psychological needs. The former corresponds to the Defi and the latter to GameFi.

StepN has done a good exploration in Defi. After research, we believe that GameFi is actually more suitable for LBS, because there are already successful web2 LBS games (such as Pokemon Go) in the industry, but no on web3.

During the design process, we investigated several classic game economy models, such as EVE, New world and Menghuanxiyou, and set the most basic output for PinTogether, we call it AP(Active point). It is generated when a user punch in at block of the map.

A user could pay APs to build Landmark store(smart contract) , the store could offer Pieces in the format of NFT. Pieces are minted(and burned) according to bounding-curve model, which is set in the Landmark contract when it is deployed.


## Roles：

1. Lord : Owner of landmark
   
2. Hunter: a Role for landmark picture nft
   
3. Wizard: Onwer of landmark sbt

## economic model

Check in on the map to earn AP points. Lord stakes AP points to produce landmark contracts on the map. Hunter uses AP points to obtain NFTs.

1 A landmark contract requires Lords to stake AP points for deployment.

2. When deploying a landmark contract, the output mode of the pieces within must be specified, such as 6 images, how many of each, how many can be produced, and is determined based on the staked AP points.

3. 90% of the output is implemented based on linear continuous ladder pricing of AP points plus some randomness, while the final 10% is locked at the highest transaction price.

4. Hunters need to use AP points to mint pieces and can acquire AP points by burning pieces.

5. Of the AP points consumed in the landmark contract, 50% will go to the Lord, and the remainder is returned to the management side."


[Demo vedio](https://drive.google.com/file/d/17b7V809sH_roFXfHzXDrVCKVvEkLVXeE/view?usp=sharing)

