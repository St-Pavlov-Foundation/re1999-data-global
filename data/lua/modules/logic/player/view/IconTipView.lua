module("modules.logic.player.view.IconTipView", package.seeall)

slot0 = class("IconTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "window/bg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "window/bg/#simage_bottom")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/right/useState/#btn_change")
	slot0._txtnameCn = gohelper.findChildText(slot0.viewGO, "window/right/#txt_nameCn")
	slot0._gousing = gohelper.findChild(slot0.viewGO, "window/right/useState/#go_using")
	slot0._simageheadIcon = gohelper.findChildSingleImage(slot0.viewGO, "window/right/#simage_headIcon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "window/right/#simage_headIcon/#go_framenode")
	slot0._btncloseBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/top/#btn_closeBtn")
	slot0._loader = MultiAbLoader.New()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncloseBtn:AddClickListener(slot0._btncloseBtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncloseBtn:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	PlayerRpc.instance:sendSetPortraitRequest(IconTipModel.instance:getSelectIcon())
end

function slot0._btncloseBtnOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot1 = PlayerModel.instance:getPlayinfo()

	IconTipModel.instance:setSelectIcon(slot1.portrait)
	IconTipModel.instance:setIconList(slot1.portrait)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	slot0._buttonbg = gohelper.findChildClick(slot0.viewGO, "maskbg")

	slot0._buttonbg:AddClickListener(slot0._btncloseBtnOnClick, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._btnconfirm.gameObject, IconTipModel.instance:getSelectIcon() ~= PlayerModel.instance:getPlayinfo().portrait)
	gohelper.setActive(slot0._gousing, slot1 == slot3)

	slot0._txtnameCn.text = lua_item.configDict[slot1].name

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadIcon)
	end

	slot0._liveHeadIcon:setLiveHead(slot4.id)

	if #string.split(slot4.effect, "#") > 1 then
		if slot4.id == tonumber(slot5[#slot5]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame then
				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		end
	else
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0._onLoadCallback(slot0)
	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
	slot0.frame:GetComponent(gohelper.Type_Image).enabled = false
	slot5 = 1.41 * recthelper.getWidth(slot0._simageheadIcon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, slot0._refreshUI, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, slot0._refreshUI, slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, slot0._refreshUI, slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.SetPortrait, slot0._refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageheadIcon:UnLoadImage()
	slot0._buttonbg:RemoveClickListener()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
