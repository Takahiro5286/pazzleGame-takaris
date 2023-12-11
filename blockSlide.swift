//
//  blockSlide.swift
//  manyBlocks
//
//  Created by user on 2023/12/07.
//

import SwiftUI

struct blockSlide: View {
    private let r: CGFloat=22
    private let g: CGFloat=1
    @State var currentLocation:(x:Int,y:Int)=(-1,-1)
    @State var cells: [Bool]=Array(repeating:false,count:50*50)
    var condition = true
    var i:Int=0
    
    var x:Int=0
    
    var colorCell:Int=0
    
    @State var cnt=0
    let center=4
    @State var going=1
    @State var centerPoint = 14
    @State var count = 0
    @State var timer :Timer?
    
    @State var blockName=""
    @State var blockState=0
    
    @State var pointFlg=true
    
    @State var gameScore=0
    
//    @State var leftFlg=false
    
    var body: some View{
        VStack {
            
            Text("Score:   " + String(gameScore))
            
            Button("start") {
                cells=Array(repeating:false,count:50*50)
                currentLocation=(-1,-1)
                blockState=0

                var allBlockName=["rightL","leftL","T","Stick","Square"]
                var allBlockIndex:Int=Int.random(in: 0...4)
                blockName=allBlockName[allBlockIndex]
                
                timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                    self.count += 1
                    
                    //一列揃っているかの判定(Judgement)
                    for j in 0...19{
                        for i in 0...9{
                            if(cells[j*10+i]==false){
                                pointFlg=false
                            }
                        }
                        if(pointFlg==true){
                            gameScore+=1000
                            print(gameScore)
                            for x in 0...9{
                                cells[j*10+x]=false
                            }
                            for colorCell in (0..<j*10).reversed(){
                                if(cells[colorCell]==true){
                                    cells[colorCell]=false
                                    cells[colorCell+10]=true
                                }
                            }
                        }
                        pointFlg=true
                    }
                    
                    //0.6秒に一度ブロックを動かす
                    if(count%1==0){
                        switch blockName{
                        case "rightL":
                            if(blockState==0){
                                cells[centerPoint-10]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                cells[centerPoint+11]=false
                                centerPoint += 10
                            }else if(blockState==1){
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+9]=false
                                centerPoint += 10
                            }else if(blockState==2){
                                cells[centerPoint-11]=false
                                cells[centerPoint-10]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                centerPoint += 10
                            }else if(blockState==3){
                                cells[centerPoint-9]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                centerPoint += 10
                            }
                            
                            
                        case "leftL":
                            if(blockState==0){
                                cells[centerPoint-10]=false
                                cells[centerPoint]=false
                                cells[centerPoint+9]=false
                                cells[centerPoint+10]=false
                                centerPoint += 10
                            }else if(blockState==1){
                                cells[centerPoint-11]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                centerPoint += 10
                            }else if(blockState==2){
                                cells[centerPoint-10]=false
                                cells[centerPoint-9]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                centerPoint += 10
                            }else if(blockState==3){
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+11]=false
                                centerPoint += 10
                            }
                            
                            
                        case "T":
                            if(blockState==0){
                                cells[centerPoint-10]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                centerPoint += 10
                            }else if(blockState==1){
                                cells[centerPoint-10]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+10]=false
                                centerPoint += 10
                            }else if(blockState==2){
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+10]=false
                                centerPoint += 10
                            }else if(blockState==3){
                                cells[centerPoint-10]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                centerPoint += 10
                            }
                            
                            
                        case "Stick":
                            if(blockState==0){
                                cells[centerPoint-10]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                cells[centerPoint+20]=false
                                centerPoint += 10
                            }else if(blockState==1){
                                cells[centerPoint-2]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                centerPoint += 10
                            }
                            
                            
                        case "Square":
                                cells[centerPoint-11]=false
                                cells[centerPoint-10]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                centerPoint += 10
                            
                            
                            
                        default:
                            print("leftL")
                        }
                    }
                    currentLocation=(-1,-1)
                    //countに入らない条件の時にブロックを描写する
                    switch blockName{
                        
                    case "rightL":
                        if(blockState==0){
                            cells[centerPoint-10]=true
                            cells[centerPoint]=true
                            cells[centerPoint+10]=true
                            cells[centerPoint+11]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }else if(cells[centerPoint+20]==true || cells[centerPoint+21]==true ){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==1){
                            //センターが一番左の時にセンターを右に１つずらす
                            if(centerPoint%10==0){
                                centerPoint+=1
                            }
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            cells[centerPoint+9]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+10]==true || cells[centerPoint+11]==true || cells[centerPoint+19]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==2){
                            cells[centerPoint-11]=true
                            cells[centerPoint-10]=true
                            cells[centerPoint]=true
                            cells[centerPoint+10]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+20]==true || cells[centerPoint-1]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==3){
                            //センターが一番左の時にセンターを右に１つずらす
                            if(centerPoint%10==9){
                                centerPoint-=1
                            }
                            cells[centerPoint-9]=true
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            //一番下まで来た時
                            if(centerPoint>=190){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+9]==true || cells[centerPoint+10]==true || cells[centerPoint+11]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }
                    
                    case "leftL":
                        if(blockState==0){
                            cells[centerPoint-10]=true
                            cells[centerPoint]=true
                            cells[centerPoint+9]=true
                            cells[centerPoint+10]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }else if(cells[centerPoint+19]==true || cells[centerPoint+20]==true ){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==1){
//                            //センターが一番左の時にセンターを右に１つずらす
//                            if((centerPoint-1)%10==0){
//                                centerPoint+=1
//                            }
                            cells[centerPoint-11]=true
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            //一番下まで来た時
                            if(centerPoint>=190){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+9]==true || cells[centerPoint+10]==true || cells[centerPoint+11]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==2){
                            cells[centerPoint-10]=true
                            cells[centerPoint-9]=true
                            cells[centerPoint]=true
                            cells[centerPoint+10]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+20]==true || cells[centerPoint+1]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==3){
//                            //センターが一番左の時にセンターを右に１つずらす
//                            if(centerPoint%10==9){
//                                centerPoint-=1
//                            }
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            cells[centerPoint+11]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+9]==true || cells[centerPoint+10]==true || cells[centerPoint+21]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }
                    case "T":
                        if(blockState==0){
                            cells[centerPoint-10]=true
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            //一番下まで来た時
                            if(centerPoint>=190){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                            else if(cells[centerPoint+9]==true || cells[centerPoint+10]==true || cells[centerPoint+11]==true ){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==1){
                            //センターが一番左の時にセンターを右に１つずらす
//                            if((centerPoint-1)%10==0){
//                                centerPoint+=1
//                            }
                            cells[centerPoint-10]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            cells[centerPoint+10]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+20]==true || cells[centerPoint+11]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==2){
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            cells[centerPoint+10]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+9]==true || cells[centerPoint+20]==true || cells[centerPoint+11]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==3){
//                            //センターが一番左の時にセンターを右に１つずらす
//                            if(centerPoint%10==9){
//                                centerPoint-=1
//                            }
                            cells[centerPoint-10]=true
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+10]=true
                            //一番下まで来た時
                            if(centerPoint>=180){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+9]==true || cells[centerPoint+20]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }
                    case "Stick":
                        if(blockState==0){
                            cells[centerPoint-10]=true
                            cells[centerPoint]=true
                            cells[centerPoint+10]=true
                            cells[centerPoint+20]=true
                            //一番下まで来た時
                            if(centerPoint>=170){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                            else if(cells[centerPoint+30]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }else if(blockState==1){
                            //センターが一番左の時にセンターを右に１つずらす
//                            if((centerPoint-1)%10==0){
//                                centerPoint+=1
//                            }
                            cells[centerPoint-2]=true
                            cells[centerPoint-1]=true
                            cells[centerPoint]=true
                            cells[centerPoint+1]=true
                            //一番下まで来た時
                            if(centerPoint>=190){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }//ブロックがすでに下にある時
                            else if(cells[centerPoint+8]==true || cells[centerPoint+9]==true || cells[centerPoint+10]==true || cells[centerPoint+11]==true){
                                centerPoint=14
                                blockState=0
                                var allBlockIndex:Int=Int.random(in: 0...4)
                                blockName=allBlockName[allBlockIndex]
                            }
                        }
                    case "Square":
                        cells[centerPoint-11]=true
                        cells[centerPoint-10]=true
                        cells[centerPoint-1]=true
                        cells[centerPoint]=true
                        //一番下まで来た時
                        if(centerPoint>=190){
                            centerPoint=14
                            blockState=0
                            var allBlockIndex:Int=Int.random(in: 0...4)
                            blockName=allBlockName[allBlockIndex]
                        }
                        else if(cells[centerPoint+9]==true || cells[centerPoint+10]==true){
                            centerPoint=14
                            blockState=0
                            var allBlockIndex:Int=Int.random(in: 0...4)
                            blockName=allBlockName[allBlockIndex]
                        }
                    default:
                        blockName="rightL"
                    }
                }
            }
        }
        
        Group {
               if condition {
                   Text("TAKARIS")
                       .font(.title)
               } else {
                   Text("Alternative View")
               }
        }
        
        
        
        
        
        
        
        
        
        
        //ブロックの描写
        VStack(spacing:g){
            ForEach(0..<20){y in
                HStack(spacing:g){
                    
                    
                    //本当はブロックごとに色を変えたいが、時間の都合上、断念する
//                    switch blockName{
//                    case "rightL":
//                        ForEach(0..<10){x in
//                            Rectangle()
//                                .frame(width: r,height: r)
//                                .foregroundColor(cells[10*y+x] ? Color.red:Color.secondary)
//                        }
//                    case "leftL":
//                        ForEach(0..<10){x in
//                            Rectangle()
//                                .frame(width: r,height: r)
//                                .foregroundColor(cells[10*y+x] ? Color.green:Color.secondary)
//                        }
//                        
//                    case "T":
//                        ForEach(0..<10){x in
//                            Rectangle()
//                                .frame(width: r,height: r)
//                                .foregroundColor(cells[10*y+x] ? Color.purple:Color.secondary)
//                        }
//                        
//                    case "Stick":
//                        ForEach(0..<10){x in
//                            Rectangle()
//                                .frame(width: r,height: r)
//                                .foregroundColor(cells[10*y+x] ? Color.blue:Color.secondary)
//                        }
//                        
//                    case "Square":
//                        ForEach(0..<10){x in
//                            Rectangle()
//                                .frame(width: r,height: r)
//                                .foregroundColor(cells[10*y+x] ? Color.yellow:Color.secondary)
//                        }
//                    default :
//                        ForEach(0..<10){x in
//                            Rectangle()
//                                .frame(width: r,height: r)
//                                .foregroundColor(cells[10*y+x] ? Color.primary:Color.secondary)
//                        }
//                    }
                    
                    ForEach(0..<10){x in
                        Rectangle()
                            .frame(width: r,height: r)
                            .foregroundColor(cells[10*y+x] ? Color.primary:Color.secondary)
                    }
                }
            }
        }

        HStack{
            //左ボタンを押した時の処理
            Button("←"){
                switch blockName{
                case "rightL":
                    if(blockState==0){
                        if(cells[centerPoint-1]==false && cells[centerPoint-11]==false && cells[centerPoint+9]==false && centerPoint % 10 != 0){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            cells[centerPoint+11]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint-2]==false && cells[centerPoint+8]==false && (centerPoint-1) % 10 != 0){
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            cells[centerPoint+9]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==2){
                        if(cells[centerPoint-1]==false && cells[centerPoint+9]==false && cells[centerPoint-12]==false && (centerPoint-1) % 10 != 0){
                            cells[centerPoint-11]=false
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==3){
                        if(cells[centerPoint-10]==false && cells[centerPoint-2]==false && (centerPoint-1) % 10 != 0){
                            cells[centerPoint-9]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint -= 1
                        }
                    }
                    
                    
                    
                case "leftL":
                    if(blockState==0){
                        if(cells[centerPoint-11]==false && cells[centerPoint-1]==false && cells[centerPoint+8]==false && (centerPoint-1) % 10 != 0){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+9]=false
                            cells[centerPoint+10]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint-12]==false && cells[centerPoint-2]==false && (centerPoint-1) % 10 != 0){
                            cells[centerPoint-11]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==2){
                        if(cells[centerPoint-11]==false && cells[centerPoint-1]==false && cells[centerPoint+9]==false && centerPoint % 10 != 0){
                                cells[centerPoint-10]=false
                                cells[centerPoint-9]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                centerPoint -= 1
                        }
                    }else if(blockState==3){
                        if(cells[centerPoint-2]==false && cells[centerPoint+10]==false && (centerPoint-1) % 10 != 0){
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+11]=false
                                centerPoint -= 1
                        }
                    }
                    
                case "T":
                    if(blockState==0){
                        if(cells[centerPoint-9]==false && cells[centerPoint-2]==false && (centerPoint-1) % 10 != 0){
                            cells[centerPoint-10]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint-11]==false && cells[centerPoint-1]==false && cells[centerPoint+9]==false && centerPoint % 10 != 0){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            cells[centerPoint+10]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==2){
                        if(cells[centerPoint-2]==false && cells[centerPoint+9]==false && (centerPoint-1) % 10 != 0){
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+10]=false
                                centerPoint -= 1
                        }
                    }else if(blockState==3){
                        if(cells[centerPoint-11]==false && cells[centerPoint-2]==false && cells[centerPoint+9]==false && (centerPoint-1) % 10 != 0){
                                cells[centerPoint-10]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                centerPoint -= 1
                        }
                    }
                    
                    
                case "Stick":
                    if(blockState==0){
                        if(cells[centerPoint-11]==false && cells[centerPoint-1]==false && cells[centerPoint+9]==false && cells[centerPoint+19]==false && centerPoint % 10 != 0){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            cells[centerPoint+20]=false
                            centerPoint -= 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint-7]==false && (centerPoint-2) % 10 != 0){
                            cells[centerPoint-2]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint -= 1
                        }
                    }
                    
                case "Square":
                    if(cells[centerPoint-12]==false && cells[centerPoint-2]==false && (centerPoint-1) % 10 != 0){
                        cells[centerPoint-11]=false
                        cells[centerPoint-10]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        centerPoint -= 1
                    }
                    
                    
                    
                default:
                    print("leftL")
                }
            }
            
            
            
            //回転ボタンを押した時の処理(横にブロックがある時の処理は後回し)
            Button("○"){
                switch blockName{
                case "rightL":
                    if(blockState==0){
                        //一番左にいる時にすぐ右にブロックがある時と、両サイドにブロックがある時に回転をロック
                        if((centerPoint%10==0&&cells[centerPoint+2]==true)||(cells[centerPoint-1]==true&&cells[centerPoint+2]==true)){
                            blockState=0
                        }
                        else{
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            cells[centerPoint+11]=false
                            blockState=1
                        }
                    }else if(blockState==1){
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+9]=false
                        blockState=2
                    }else if(blockState==2){
                        //一番右にいる時にすぐ左にブロックがある時と、両サイドにブロックがある時に回転をロック
                        if((centerPoint%10==9&&cells[centerPoint-9]==true)||(cells[centerPoint-2]==true||cells[centerPoint+1]==true||cells[centerPoint+8]==true||cells[centerPoint+11]==true)){
                            blockState=2
                        }//上記のif文に当てはまらなければ通常通りの描写
                        else{
                            cells[centerPoint-11]=false
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            blockState=3
                        }
                    }else if(blockState==3){
                        cells[centerPoint-9]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        blockState=0
                    }
                case "leftL":
                    if(blockState==0){
//                        //一番左にいる時にすぐ右にブロックがある時と、両サイドにブロックがある時に回転をロック
//                        if((centerPoint%10==0&&cells[centerPoint+2]==true)||(cells[centerPoint-1]==true&&cells[centerPoint+2]==true)){
//                            blockState=0
//                        }
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+9]=false
                        cells[centerPoint+10]=false
                        blockState=1
                    }else if(blockState==1){
                        cells[centerPoint-11]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        blockState=2
                    }else if(blockState==2){
//                        //一番右にいる時にすぐ左にブロックがある時と、両サイドにブロックがある時に回転をロック
//                        if((centerPoint%10==9&&cells[centerPoint-9]==true)||(cells[centerPoint-2]==true||cells[centerPoint+1]==true||cells[centerPoint+8]==true||cells[centerPoint+11]==true)){
//                            blockState=2
//                        }//上記のif文に当てはまらなければ通常通りの描写
                        
                        cells[centerPoint-10]=false
                        cells[centerPoint-9]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        blockState=3
                    }else if(blockState==3){
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+11]=false
                        blockState=0
                    }
                    
                    
                case "T":
                    if(blockState==0){
//                        //一番左にいる時にすぐ右にブロックがある時と、両サイドにブロックがある時に回転をロック
//                        if((centerPoint%10==0&&cells[centerPoint+2]==true)||(cells[centerPoint-1]==true&&cells[centerPoint+2]==true)){
//                            blockState=0
//                        }
                        cells[centerPoint-10]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        blockState=1
                    }else if(blockState==1){
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+10]=false
                        blockState=2
                    }else if(blockState==2){
//                        //一番右にいる時にすぐ左にブロックがある時と、両サイドにブロックがある時に回転をロック
//                        if((centerPoint%10==9&&cells[centerPoint-9]==true)||(cells[centerPoint-2]==true||cells[centerPoint+1]==true||cells[centerPoint+8]==true||cells[centerPoint+11]==true)){
//                            blockState=2
//                        }//上記のif文に当てはまらなければ通常通りの描写
                        
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+10]=false
                        blockState=3
                    }else if(blockState==3){
                        cells[centerPoint-10]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        blockState=0
                    }
                    
                    
                case "Stick":
                    if(blockState==0){
//                        //一番左にいる時にすぐ右にブロックがある時と、両サイドにブロックがある時に回転をロック
//                        if((centerPoint%10==0&&cells[centerPoint+2]==true)||(cells[centerPoint-1]==true&&cells[centerPoint+2]==true)){
//                            blockState=0
//                        }
                        
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        cells[centerPoint+20]=false
                        blockState=1
                    }else if(blockState==1){
                        cells[centerPoint-2]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        blockState=0
                    }
                    
                case "Square":
                    blockState=0
                    
                    
                    
                default:
                    blockName="rightL"
                }
            }
            .padding()
            
            
            
            //右ボタンを押した時の処理
            Button("→"){
                switch blockName{
                case "rightL":
                    if(blockState==0){
                        if(cells[centerPoint+12]==false && cells[centerPoint+1]==false && cells[centerPoint-9]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            cells[centerPoint+11]=false
                            centerPoint += 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint+2]==false && cells[centerPoint+10]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            cells[centerPoint+9]=false
                            centerPoint += 1
                        }
                    }else if(blockState==2){
                        if(cells[centerPoint-9]==false && cells[centerPoint+1]==false && cells[centerPoint+11]==false && (centerPoint) % 10 != 9){
                            cells[centerPoint-11]=false
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            centerPoint += 1
                        }
                    }else if(blockState==3){
                        if(cells[centerPoint-8]==false && cells[centerPoint+2]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-9]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint += 1
                        }
                    }
                    
                    
                case "leftL":
                    if(blockState==0){
                        if(cells[centerPoint-9]==false && cells[centerPoint+1]==false && cells[centerPoint+11]==false && centerPoint % 10 != 9){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+9]=false
                            cells[centerPoint+10]=false
                            centerPoint += 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint+2]==false && cells[centerPoint+10]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-11]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint += 1
                        }
                    }else if(blockState==2){
                        if(cells[centerPoint-8]==false && cells[centerPoint+1]==false && cells[centerPoint+11]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-10]=false
                            cells[centerPoint-9]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            centerPoint += 1
                        }
                    }else if(blockState==3){
                        if(cells[centerPoint+12]==false && cells[centerPoint+2]==false && (centerPoint+1) % 10 != 9){
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+1]=false
                                cells[centerPoint+11]=false
                                centerPoint += 1
                        }
                    }
                    
                    
                    
                case "T":
                    if(blockState==0){
                        if(cells[centerPoint-9]==false && cells[centerPoint+2]==false && (centerPoint-1) % 10 != 9){
                            cells[centerPoint-10]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint += 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint-9]==false && cells[centerPoint+2]==false && cells[centerPoint+11]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            cells[centerPoint+10]=false
                            centerPoint += 1
                        }
                    }else if(blockState==2){
                        if(cells[centerPoint+2]==false && cells[centerPoint+11]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            cells[centerPoint+10]=false
                            centerPoint += 1
                        }
                    }else if(blockState==3){
                        if(cells[centerPoint-9]==false && cells[centerPoint+1]==false && cells[centerPoint+11]==false && centerPoint % 10 != 9){
                                cells[centerPoint-10]=false
                                cells[centerPoint-1]=false
                                cells[centerPoint]=false
                                cells[centerPoint+10]=false
                                centerPoint += 1
                        }
                    }
                    
                    
                case "Stick":
                    if(blockState==0){
                        if(cells[centerPoint-9]==false && cells[centerPoint+1]==false && cells[centerPoint+11]==false && cells[centerPoint+1]==false && centerPoint % 10 != 9){
                            cells[centerPoint-10]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            cells[centerPoint+20]=false
                            centerPoint += 1
                        }
                    }else if(blockState==1){
                        if(cells[centerPoint+2]==false && (centerPoint+1) % 10 != 9){
                            cells[centerPoint-2]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            centerPoint += 1
                        }
                    }
                    
                    
                case "Square":
                    if(cells[centerPoint-9]==false && cells[centerPoint+1]==false && centerPoint % 10 != 9){
                        cells[centerPoint-11]=false
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint-1]=false
                        centerPoint += 1
                    }
                
                    
                    
                    
                    
                default:
                    print("leftL")
                }
            }
        }
        //下ボタンを押した時の処理
        Button("↓"){
            switch blockName{
            case "rightL":
                if(blockState==0){
                    if(cells[centerPoint+20]==false && cells[centerPoint+21]==false && cells[centerPoint+30]==false && cells[centerPoint+31]==false && centerPoint<170){
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        cells[centerPoint+11]=false
                        centerPoint += 10
                    }
                }else if(blockState==1){
                    if(cells[centerPoint+20]==false && cells[centerPoint+21]==false && cells[centerPoint+39]==false && centerPoint<170){
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+9]=false
                        centerPoint += 10
                    }
                }else if(blockState==2){
                    if(cells[centerPoint+9]==false && cells[centerPoint+30]==false && cells[centerPoint+20]==false && centerPoint<170){
                        cells[centerPoint-11]=false
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        centerPoint += 10
                    }
                }else if(blockState==3){
                    if(cells[centerPoint+19]==false && cells[centerPoint+20]==false && cells[centerPoint+21]==false && centerPoint<170){
                        cells[centerPoint-9]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        centerPoint += 10
                    }
                }
                
                
                
            case "leftL":
                if(blockState==0){
                    if(cells[centerPoint+19]==false && cells[centerPoint+20]==false && cells[centerPoint+29]==false && cells[centerPoint+30]==false && centerPoint<170){
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+9]=false
                        cells[centerPoint+10]=false
                        centerPoint += 10
                    }
                }else if(blockState==1){
                    if(cells[centerPoint+20]==false && cells[centerPoint+21]==false && cells[centerPoint+39]==false && centerPoint<170){
                        cells[centerPoint-11]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        centerPoint += 10
                    }
                }else if(blockState==2){
                    if(cells[centerPoint+9]==false && cells[centerPoint+30]==false && cells[centerPoint+20]==false && centerPoint<170){
                        cells[centerPoint-10]=false
                        cells[centerPoint-9]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        centerPoint += 10
                    }
                }else if(blockState==3){
                    if(cells[centerPoint+19]==false && cells[centerPoint+20]==false && cells[centerPoint+21]==false && centerPoint<170){
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+1]=false
                            cells[centerPoint+11]=false
                            centerPoint += 10
                    }
                }
                
                
            case "T":
                if(blockState==0){
                    if(cells[centerPoint+9]==false && cells[centerPoint+10]==false && cells[centerPoint+11]==false && centerPoint<170){
                        cells[centerPoint-10]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        centerPoint += 10
                    }
                }else if(blockState==1){
                    if(cells[centerPoint+11]==false && cells[centerPoint+20]==false && centerPoint<170){
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+10]=false
                        centerPoint += 10
                    }
                }else if(blockState==2){
                    if(cells[centerPoint+9]==false && cells[centerPoint+11]==false && cells[centerPoint+20]==false && centerPoint<170){
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        cells[centerPoint+10]=false
                        centerPoint += 10
                    }
                }else if(blockState==3){
                    if(cells[centerPoint+9]==false && cells[centerPoint+20]==false && centerPoint<170){
                            cells[centerPoint-10]=false
                            cells[centerPoint-1]=false
                            cells[centerPoint]=false
                            cells[centerPoint+10]=false
                            centerPoint += 10
                    }
                }
                
                
                
            case "Stick":
                if(blockState==0){
                    if(cells[centerPoint+40]==false && cells[centerPoint+30]==false && centerPoint<160){
                        cells[centerPoint-10]=false
                        cells[centerPoint]=false
                        cells[centerPoint+10]=false
                        cells[centerPoint+20]=false
                        centerPoint += 10
                    }
                }else if(blockState==1){
                    if(cells[centerPoint+8]==false && cells[centerPoint+9]==false && cells[centerPoint+10]==false && cells[centerPoint+11]==false && cells[centerPoint+18]==false && cells[centerPoint+19]==false && cells[centerPoint+20]==false && cells[centerPoint+21]==false && centerPoint<180){
                        cells[centerPoint-2]=false
                        cells[centerPoint-1]=false
                        cells[centerPoint]=false
                        cells[centerPoint+1]=false
                        centerPoint += 10
                    }
                }
                
                
            case "Square":
                if(cells[centerPoint+9]==false && cells[centerPoint+10]==false && cells[centerPoint+19]==false && cells[centerPoint+20]==false && centerPoint<180){
                    cells[centerPoint-11]=false
                    cells[centerPoint-10]=false
                    cells[centerPoint-1]=false
                    cells[centerPoint]=false
                    centerPoint += 10
                }
                
                
                
            default:
                print("rightL")
            }
        }
                
//        //パネルをタッチした後の処理
//        .gesture(
//            DragGesture(minimumDistance:0)
//                .onChanged({value in
//                    let x=Int(value.location.x/(r+g))
//                    let y=Int(value.location.y/(r+g))
//                    if(0..<10).contains(x),(0..<20).contains(y){
//                        if currentLocation.x != x || currentLocation.y != y{
//                            currentLocation=(x,y)
//                            cells[10*y+x]=true
//                        }
//                    }
//                })
//                .onEnded({value in
//                    cells=Array(repeating:false,count:50*50)
//                    currentLocation=(-1,-1)
//                    
//                })
//        )
//        .padding()
    }

}

#Preview {
    blockSlide()
}
