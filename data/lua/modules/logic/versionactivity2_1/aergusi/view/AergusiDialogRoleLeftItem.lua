module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleLeftItem", package.seeall)

slot0 = class("AergusiDialogRoleLeftItem", AergusiDialogRoleItemBase)
slot1 = -4.9039
slot2 = 22

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._resPath = slot2
	slot0._golight = gohelper.findChild(slot1, "light")
	slot0._gochess = gohelper.findChild(slot1, "chessitem")
	slot0._simagechess = gohelper.findChildSingleImage(slot1, "chessitem/#chess")
	slot0._gotalk = gohelper.findChild(slot1, "go_talking")
	slot0._gobubble = gohelper.findChild(slot1, "go_bubble")
	slot0._gospeakbubble = gohelper.findChild(slot1, "go_bubble/go_speakbubble")
	slot0._txtspeakbubbledesc = gohelper.findChildText(slot1, "go_bubble/go_speakbubble/txt_dec")
	slot0._gothinkbubble = gohelper.findChild(slot1, "go_bubble/go_thinkbubble")
	slot0._txtthinkbubbledesc = gohelper.findChildText(slot1, "go_bubble/go_thinkbubble/txt_dec")
	slot0._gopatience = gohelper.findChild(slot1, "#go_patience")
	slot0._imageprogress = gohelper.findChildImage(slot1, "#go_patience/#image_progress")
	slot0._goprogress = gohelper.findChild(slot1, "#go_patience/#progress")

	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._gobubble, false)
	gohelper.setActive(slot0._golight, false)
	gohelper.setActive(slot0._gotalk, false)

	slot0._chessAni = slot0._gochess:GetComponent(typeof(UnityEngine.Animator))
	slot0._progressAni = slot0._goprogress:GetComponent(typeof(UnityEngine.Animator))

	slot0:showPatience()
	slot0._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(slot0._resPath))
	slot0:_addEvents()

	slot0._txtspeakbubbledescMarkTopIndex = slot0:createMarktopCmp(slot0._txtspeakbubbledesc)
	slot0._txtthinkbubbledescMarkTopIndex = slot0:createMarktopCmp(slot0._txtthinkbubbledesc)

	slot0:setTopOffset(slot0._txtspeakbubbledescMarkTopIndex, 0, uv0)
	slot0:setTopOffset(slot0._txtthinkbubbledescMarkTopIndex, 0, uv0)
	slot0:setLineSpacing(slot0._txtspeakbubbledescMarkTopIndex, uv1)
	slot0:setLineSpacing(slot0._txtthinkbubbledescMarkTopIndex, uv1)
end

function slot0.showTalking(slot0)
	slot0._chessAni:Play("jump", 0, 0)
	gohelper.setActive(slot0._golight, true)
	gohelper.setActive(slot0._gotalk, true)
	TaskDispatcher.runDelay(slot0.hideTalking, slot0, 3)
end

function slot0.hideTalking(slot0)
	TaskDispatcher.cancelTask(slot0.hideTalking, slot0)
	gohelper.setActive(slot0._golight, false)
	gohelper.setActive(slot0._gotalk, false)
end

function slot0.showPatience(slot0)
	gohelper.setActive(slot0._gopatience, true)

	slot1 = AergusiDialogModel.instance:getLeftErrorTimes()
	slot0._imageprogress.fillAmount = slot1 / AergusiConfig.instance:getEpisodeConfig(nil, AergusiModel.instance:getCurEpisode()).maxError

	if slot1 == 3 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(slot0._imageprogress, "v2a1_aergusi_chat_progress_green")
	elseif slot1 == 2 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(slot0._imageprogress, "v2a1_aergusi_chat_progress_yellow")
		gohelper.setActive(slot0._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		slot0._progressAni:Play("toyellow")
	elseif slot1 == 1 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(slot0._imageprogress, "v2a1_aergusi_chat_progress_red")
		gohelper.setActive(slot0._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		slot0._progressAni:Play("tored")
	else
		gohelper.setActive(slot0._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		slot0._progressAni:Play("toempty")
	end
end

function slot0.showBubble(slot0, slot1)
	gohelper.setActive(slot0._gobubble, true)

	if slot1.bubbleType == AergusiEnum.DialogBubbleType.Speaker then
		gohelper.setActive(slot0._gospeakbubble, true)
		gohelper.setActive(slot0._gothinkbubble, false)
		slot0:setTextWithMarktopByIndex(slot0._txtspeakbubbledescMarkTopIndex, slot1.content)
	else
		gohelper.setActive(slot0._gothinkbubble, true)
		gohelper.setActive(slot0._gospeakbubble, false)
		slot0:setTextWithMarktopByIndex(slot0._txtthinkbubbledescMarkTopIndex, slot1.content)
	end
end

function slot0.hideBubble(slot0)
	gohelper.setActive(slot0._gobubble, false)
end

function slot0._addEvents(slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnStartErrorBubbleDialog, slot0._onStartErrorBubbleDialog, slot0)
end

function slot0._removeEvents(slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnStartErrorBubbleDialog, slot0._onStartErrorBubbleDialog, slot0)
end

function slot0._onStartErrorBubbleDialog(slot0, slot1)
	slot0:showPatience()
end

function slot0.destroy(slot0)
	slot0._simagechess:UnLoadImage()
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0.hideTalking, slot0)
	uv0.super.destroy(slot0)
end

return slot0
