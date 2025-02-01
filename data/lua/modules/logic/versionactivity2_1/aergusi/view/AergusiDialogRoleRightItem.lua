module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleRightItem", package.seeall)

slot0 = class("AergusiDialogRoleRightItem", AergusiDialogRoleItemBase)
slot1 = -4.9039
slot2 = 22

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._resPath = slot2
	slot0._golight = gohelper.findChild(slot1, "light")
	slot0._gochess = gohelper.findChild(slot1, "#chessitem")
	slot0._simagechess = gohelper.findChildSingleImage(slot1, "#chessitem/#chess")
	slot0._gotalk = gohelper.findChild(slot1, "go_talking")
	slot0._gobubble = gohelper.findChild(slot1, "go_bubble")
	slot0._gospeakbubble = gohelper.findChild(slot1, "go_bubble/go_speakbubble")
	slot0._txtspeakbubbledesc = gohelper.findChildText(slot1, "go_bubble/go_speakbubble/txt_dec")
	slot0._gothinkbubble = gohelper.findChild(slot1, "go_bubble/go_thinkbubble")
	slot0._txtthinkbubbledesc = gohelper.findChildText(slot1, "go_bubble/go_thinkbubble/txt_dec")
	slot0._goemo = gohelper.findChild(slot1, "emobg")
	slot0._chessAni = slot0._gochess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._golight, false)
	gohelper.setActive(slot0._gotalk, false)
	gohelper.setActive(slot0._gobubble, false)
	gohelper.setActive(slot0._goemo, false)
	slot0._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(slot0._resPath))

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
	gohelper.setActive(slot0._gotalk, false)
	gohelper.setActive(slot0._golight, false)
end

function slot0.showEmo(slot0)
	gohelper.setActive(slot0._goemo, true)
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

function slot0.destroy(slot0)
	slot0._simagechess:UnLoadImage()
	uv0.super.destroy(slot0)
end

return slot0
