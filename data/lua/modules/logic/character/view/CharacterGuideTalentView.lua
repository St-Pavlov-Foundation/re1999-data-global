module("modules.logic.character.view.CharacterGuideTalentView", package.seeall)

slot0 = class("CharacterGuideTalentView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_bg")
	slot0._simagehead = gohelper.findChildSingleImage(slot0.viewGO, "#simage_head")
	slot0._btnlook = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_look")
	slot0._simagedecorate1 = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_decorate1")
	slot0._simagedecorate3 = gohelper.findChildSingleImage(slot0.viewGO, "commen/#simage_decorate3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlook:AddClickListener(slot0._btnlookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlook:RemoveClickListener()
end

function slot0._btnlookOnClick(slot0)
	CharacterModel.instance:setSortByRankDescOnce()

	if ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.GuideTransitionBlackView)
	else
		ViewMgr.instance:closeAllPopupViews()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	slot0._simagehead:LoadImage(ResUrl.getCharacterTalentUpIcon("yd_sixugongming"))
	slot0._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	slot0._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.GuideTransitionBlackView then
		if not ViewMgr.instance:isOpen(ViewName.MainView) then
			ViewMgr.instance:openView(ViewName.MainView)
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.GuideTransitionBlackView
		})
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterGuideTalentView then
		ViewMgr.instance:closeView(ViewName.GuideTransitionBlackView)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagehead:UnLoadImage()
	slot0._simagedecorate1:UnLoadImage()
	slot0._simagedecorate3:UnLoadImage()
end

return slot0
