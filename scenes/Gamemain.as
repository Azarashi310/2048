﻿package scenes {
	
	import flash.display.MovieClip;
	import elements.Block;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import table.BlockPlaceTable;
	
	public class Gamemain extends MovieClip {
		
		//表示するブロック
		private var block1:Block = new Block();
		
		//ブロックmcを格納しておくやつ
		private var blockArr:Array = new Array();
		
		//キーボード
		private var keybuf:Array = new Array();
		
		//ブロックの位置の記憶
		private var blockPlace:Array = new Array();
		
		public function Gamemain() 
		{
			// constructor code
			
			//初期化
			init();
		}
		
		//初期化
		private function init():void
		{
			
			//フォーカス時の枠色を消す
			focusRect = false;
			//キー操作を受付けさせる
			stage.focus = this;
			
			//ブロック全表示
			/*
			 * 
			 * 仕組み
			 * 第一for(縦)
			 * 第二for（横）
			 * 
			 * ブロックの位置
			 * x = blockのマージン（左端）　
			 * ＋　ブロックのマージン（ブロック同士の間があるときのみ） * 2 * i(ブロックが1以上ならば)　
			 * ＋　ブロックの横幅　* i(ブロックの個数)
			 * 
			 * y = blockのマージン（上）　
			 * ＋　blockのマージン（上に隣接するブロックがあるときのみ　つまり　2行目以降） * i_y(ブロックの行数) * 2
			 * ＋ blockの高さ * i_y(ブロックの個数)
			 * 
			for (var i_y:int = 0; i_y < 4; i_y++ )
			{
				for (var i:int = 0; i < 4; i++ )
				{
					blockArr[i + 4 * i_y] = new Block();
					
					//空白マージンの指定
					blockArr[i + 4 * i_y].x = block1.margin + block1.margin * 2 * i + block1.width * i;
					if (i_y != 0)
					{
						blockArr[i + 4 * i_y].y = block1.margin_Y + block1.margin * i_y * 2 + block1.height * i_y;
					}
					else
					{
						blockArr[i + 4 * i_y].y = block1.margin_Y;
					}
					//表示
					addChild(blockArr[i + 4 * i_y]);
				}
			}
			*/
			
			//ランダムに一個ブロックを表示させる
			/*
			 * ブロックの表示する高さと横をランダムで
			 */
			createBlock();
			
			//キーボードイベント関連
			addEventListener(KeyboardEvent.KEY_DOWN, keydownEventHandler);
			addEventListener(KeyboardEvent.KEY_UP, keyupEventHandler);
		}
		
		//キーボードのイベント
		private function keyupEventHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == 13)
			{
				createBlock();
			}
			keybuf[e.keyCode] = false;
		}
		
		private function keydownEventHandler(e:KeyboardEvent):void 
		{
			keybuf[e.keyCode] = true;
		}
		
		//ランダムにブロックを生成
		private function createBlock():void
		{
			//高さ
			var block_X:int = 0;
			//横
			var block_Y:int = 0;
			
			//配列の長さ
			var block_num:int = blockArr.length;
			
			//配置済みであるかどうかの確認
			var blockIsExist:Boolean = false;
			
			//乱数の生成
			block_X = Math.random() * 4 << 0;
			block_Y = Math.random() * 4 << 0;
			
			trace(block_X);
			trace(block_Y);
			
			//ブロックが存在するか確認する
			if (blockArr.length != 0)
			{
				blockIsExist = getBlockPlace(block_X, block_Y);
				trace(blockIsExist);
			}
			if (blockIsExist == true)
			{
				for (var i = 0; i < 10; i++ )
				{
					//乱数の生成
					block_X = Math.random() * 3 << 0;
					block_Y = Math.random() * 3 << 0;
					
					//ブロックが存在するか確認する
					blockIsExist = getBlockPlace(block_X, block_Y);
					if (blockIsExist == false)
					{
						break;
					}
				}
			}
			
			//ブロックの生成
			blockArr[block_num] = new Block();
			
			//Xの位置の座標
			blockArr[block_num].x = block1.margin + block1.margin * 2 * block_X + block1.width * block_X;
			
			//Yの位置の座標
			if (block_Y != 0)
			{
				blockArr[block_num].y = block1.margin_Y + block1.margin * block_Y * 2 + block1.height * block_Y;
			}
			else
			{
				blockArr[block_num].y = block1.margin_Y;
			}
			
			//ブロックの配置位置表に記憶させる
			setBlockPlace();
			
			addChild(blockArr[block_num]);
		}
		
		//ブロックの位置の設定
		private function setBlockPlace():void
		{
			trace("blockArrの長さ :" + blockArr.length);
			var test:int;
			for (var i = 0; i < blockArr.length; i++ )
			{
				blockPlace[BlockPlaceTable.setTable[blockArr[i].y][blockArr[i].x]] = true;
			}
		}
		
		//ブロックの被りがあるかどうかを調べる
		private function getBlockPlace(block_x:int, block_y:int):Boolean
		{
			if (blockPlace[BlockPlaceTable.getTable[block_y][block_x]] == true)
			{
				trace("被ってる");
				return true;
			}
			return false;
		}
	}
	
}
