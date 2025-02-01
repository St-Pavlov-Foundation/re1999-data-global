module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandChessNpc", package.seeall)

slot0 = class("FairyLandChessNpc", FairyLandElementBase)
slot0.Setting = {
	[2] = {
		chat = "fairyland_chat01",
		chess = "fairyland_chess1"
	},
	[4] = {
		chat = "fairyland_chat02",
		chess = "fairyland_chess2"
	},
	[6] = {
		chat = "fairyland_chat03",
		chess = "fairyland_chess3"
	},
	[8] = {
		chat = "fairyland_chat04",
		chess = "fairyland_chess4"
	}
}

function slot0.onInitView(slot0)
	slot0.rootGo = gohelper.findChild(slot0._go, "root")
	slot0.imgChessRoot = gohelper.findChild(slot0.rootGo, "image_Chess")
	slot0.animChess = slot0.imgChessRoot:GetComponent(typeof(UnityEngine.Animator))
	slot0.imgChess = gohelper.findChildImage(slot0.rootGo, "image_Chess/#image_chess/image_chess")
	slot0.goChess = slot0.imgChess.gameObject
	slot0.goChat = gohelper.findChild(slot0.rootGo, "#image_Chat")
	slot0.imageChat = gohelper.findChildImage(slot0.rootGo, "#image_Chat")

	gohelper.setActive(slot0.goChat, false)

	slot0.chatClick = gohelper.findChildClickWithAudio(slot0.rootGo, "#image_Chat")

	slot0.chatClick:AddClickListener(slot0.onClickChat, slot0)

	slot1 = uv0.Setting[slot0._config.type]

	UISpriteSetMgr.instance:setFairyLandSprite(slot0.imgChess, slot1.chess, true)
	UISpriteSetMgr.instance:setFairyLandSprite(slot0.imageChat, slot1.chat, true)
end

function slot0.onDestroyElement(slot0)
	slot0.chatClick:RemoveClickListener()
end

function slot0.onRefresh(slot0)
	slot1 = slot0:getCurPuzzle()
	slot3 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot1)

	if FairyLandModel.instance:isPassPuzzle(slot1) and FairyLandModel.instance:isFinishDialog(slot3.successTalkId) then
		slot0:setFinish()

		return
	end

	if slot3.beforeTalkId == 0 or not FairyLandModel.instance:isFinishElement(slot0:getElementId() - 1) then
		gohelper.setActive(slot0.goChat, false)
	else
		gohelper.setActive(slot0.goChat, not FairyLandModel.instance:isFinishDialog(slot4))
	end
end

function slot0.onClickChat(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bubble_click)
	FairyLandController.instance:openDialogView({
		dialogId = FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot0:getCurPuzzle()).beforeTalkId,
		dialogType = FairyLandEnum.DialogType.Bubble,
		leftElement = FairyLandModel.instance:getDialogElement(),
		rightElement = slot0
	})
	gohelper.setActive(slot0.goChat, false)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetTextBgVisible)
end

function slot0.getCurPuzzle(slot0)
	for slot5, slot6 in ipairs(string.splitToNumber(slot0._config.puzzleId, "#")) do
		if not FairyLandModel.instance:isPassPuzzle(slot6) then
			return slot6
		end
	end

	return slot1[#slot1]
end

function slot0.getClickGO(slot0)
	return slot0.goChess
end

function slot0.playDialog(slot0)
	slot0.animChess:Play("jump", 0, 0)
end

return slot0
