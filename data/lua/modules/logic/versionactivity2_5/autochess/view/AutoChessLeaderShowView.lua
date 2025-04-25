module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderShowView", package.seeall)

slot0 = class("AutoChessLeaderShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._goCard = gohelper.findChild(slot0.viewGO, "#go_Card")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.LeaderCardPath, slot0._goCard), AutoChessLeaderCard):setData(slot0.viewParam)
	end
end

return slot0
