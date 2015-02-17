package scenes {
	
	import flash.display.MovieClip;
	import elements.Block;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
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
			stage.focus;
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
			
			//キーボードイベント関連
			addEventListener(KeyboardEvent.KEY_DOWN, keydownEventHandler);
			addEventListener(KeyboardEvent.KEY_UP, keyupEventHandler);
		}
		
		//キーボードのイベント
		private function keyupEventHandler(e:KeyboardEvent):void 
		{
			keybuf[e.keyCode] = false;
		}
		
		private function keydownEventHandler(e:KeyboardEvent):void 
		{
			keybuf[e.keyCode] = true;
		}
		
	}
	
}
