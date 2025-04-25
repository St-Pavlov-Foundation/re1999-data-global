module("modules.logic.playercard.view.comp.PlayerCardPlayerInfo", package.seeall)

slot0 = class("PlayerCardPlayerInfo", BaseView)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.canOpen(slot0)
	slot0:onOpen()
	slot0:addEvents()
end

function slot0.onInitView(slot0)
	slot0.go = gohelper.findChild(slot0.viewGO, "root/main/playerinfo")
	slot0._simageheadicon = gohelper.findChildSingleImage(slot0.go, "ani/headframe/#simage_headicon")
	slot0._btnheadicon = gohelper.findChildButtonWithAudio(slot0.go, "ani/headframe/#simage_headicon")
	slot0._goframenode = gohelper.findChild(slot0.go, "ani/headframe/#simage_headicon/#go_framenode")
	slot0._txtlevel = gohelper.findChildText(slot0.go, "ani/lv/#txt_level")
	slot0._txtplayerid = gohelper.findChildText(slot0.go, "ani/#txt_playerid")
	slot0._btnplayerid = gohelper.findChildButtonWithAudio(slot0.go, "ani/#txt_playerid/#btn_playerid")
	slot0._txtname = gohelper.findChildText(slot0.go, "ani/#txt_name")
end

function slot0.addEvents(slot0)
	slot0._btnplayerid:AddClickListener(slot0._btnplayeridOnClick, slot0)
	slot0._btnheadicon:AddClickListener(slot0._changeIcon, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, slot0.onRefreshView, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, slot0.onRefreshView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnplayerid:RemoveClickListener()
	slot0._btnheadicon:RemoveClickListener()
end

function slot0._changeIcon(slot0)
	if slot0:isPlayerSelf() then
		ViewMgr.instance:openView(ViewName.IconTipView)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)
	end
end

function slot0.onOpen(slot0)
	slot0.userId = slot0.viewParam.userId

	slot0:updateBaseInfo()
end

function slot0.getCardInfo(slot0)
	return PlayerCardModel.instance:getCardInfo(slot0.userId)
end

function slot0.isPlayerSelf(slot0)
	return slot0:getCardInfo() and slot1:isSelf()
end

function slot0.getPlayerInfo(slot0)
	return slot0:getCardInfo() and slot1:getPlayerInfo()
end

function slot0._btnplayeridOnClick(slot0)
	if not slot0:getPlayerInfo() then
		return
	end

	slot0._txtplayerid.text = slot1.userId

	ZProj.UGUIHelper.CopyText(slot0._txtplayerid.text)

	slot0._txtplayerid.text = string.format("ID:%s", slot1.userId)

	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function slot0.onRefreshView(slot0)
	slot0:updateBaseInfo()
end

function slot0.updateBaseInfo(slot0)
	if not slot0:getPlayerInfo() then
		return
	end

	slot0._txtname.text = slot1.name
	slot0._txtplayerid.text = string.format("ID:%s", slot1.userId)
	slot0._txtlevel.text = slot1.level
	slot2 = lua_item.configDict[slot1.portrait]

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadicon)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.portrait)

	if #string.split(slot2.effect, "#") > 1 then
		if slot2.id == tonumber(slot3[#slot3]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame and not slot0._loader then
				slot0._loader = MultiAbLoader.New()

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
	slot5 = 1.41 * recthelper.getWidth(slot0._simageheadicon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0.onDestroy(slot0)
	slot0._simageheadicon:UnLoadImage()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0:removeEvents()
end

return slot0
