module("modules.logic.rouge.view.RougeFactionIllustrationView", package.seeall)

slot0 = class("RougeFactionIllustrationView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "Middle/#scroll_view")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)

	for slot6, slot7 in ipairs(RougeOutsideModel.instance:getSeasonStyleInfoList()) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContent), RougeFactionIllustrationItem):onUpdateMO(slot7)
	end
end

function slot0.onClose(slot0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Faction) > 0 then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Faction, 0)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
