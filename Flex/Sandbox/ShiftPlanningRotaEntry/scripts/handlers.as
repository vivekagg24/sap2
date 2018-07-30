// ActionScript file
import mx.rpc.events.ResultEvent;
import mx.controls.Alert;

private function saveRotaResultHandler(event:ResultEvent):void{	Alert.show(event.result.EX_RETURN_MESSAGE);			}