module("modules.logic.playercard.view.comp.PlayerCardPlayerInfo", package.seeall)

slot0 = class("PlayerCardPlayerInfo", BasePlayerCardComp)

function slot0.onInitView(slot0)
	slot0._simageheadicon = gohelper.findChildSingleImage(slot0.viewGO, "headframe/#simage_headicon")
	slot0._btnheadicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "headframe/#simage_headicon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "headframe/#simage_headicon/#go_framenode")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "lv/#txt_level")
	slot0._txtplayerid = gohelper.findChildText(slot0.viewGO, "#txt_playerid")
	slot0._btnplayerid = gohelper.findChildButtonWithAudio(slot0.viewGO, "#txt_playerid/#btn_playerid")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._gosignature = gohelper.findChild(slot0.viewGO, "signature")
	slot0._txtsignature = gohelper.findChildText(slot0.viewGO, "signature/scroll/viewport/#txt_signature")
	slot0._btnsignature = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_signature")
	slot0._btnlist = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_list")
end

function slot0.addEventListeners(slot0)
	slot0._btnplayerid:AddClickListener(slot0._btnplayeridOnClick, slot0)
	slot0._btnsignature:AddClickListener(slot0._btnsignatureOnClick, slot0)
	slot0._btnheadicon:AddClickListener(slot0._changeIcon, slot0)
	slot0._btnlist:AddClickListener(slot0._onClickBtnList, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnplayerid:RemoveClickListener()
	slot0._btnsignature:RemoveClickListener()
	slot0._btnheadicon:RemoveClickListener()
	slot0._btnlist:RemoveClickListener()
end

function slot0._onClickBtnList(slot0)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowListBtn, slot0._btnlist)
end

function slot0._changeIcon(slot0)
	if slot0:isPlayerSelf() and slot0.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.IconTipView)
	end
end

function slot0.getPlayerInfo(slot0)
	return slot0.cardInfo and slot0.cardInfo:getPlayerInfo()
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

function slot0._btnsignatureOnClick(slot0)
	if slot0:isPlayerSelf() and slot0.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.Signature)
	end
end

function slot0.onRefreshView(slot0)
	slot0:updateBaseInfo()
	slot0:refreshStatus()
end

function slot0.updateBaseInfo(slot0)
	if not slot0:getPlayerInfo() then
		return
	end

	slot0._txtname.text = slot1.name
	slot0._txtplayerid.text = string.format("ID:%s", slot1.userId)
	slot0._txtlevel.text = slot1.level

	if string.nilorempty(slot1.signature) and string.split(CommonConfig.instance:getConstStr(ConstEnum.RoleRandomSignature), "#") and #slot3 > 0 then
		slot2 = slot3[math.random(1, #slot3)]
	end

	slot0._txtsignature.text = slot2

	gohelper.setActive(slot0._txtsignature.gameObject, true)

	slot3 = lua_item.configDict[slot1.portrait]

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadicon)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.portrait)

	if #string.split(slot3.effect, "#") > 1 then
		if slot3.id == tonumber(slot4[#slot4]) then
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

function slot0.refreshStatus(slot0)
	slot1 = slot0:isPlayerSelf()

	gohelper.setActive(slot0._gosignature, SDKNativeUtil.isGamePad() == false)
	gohelper.setActive(slot0._btnsignature, slot1 and slot0.compType == PlayerCardEnum.CompType.Normal)
	gohelper.setActive(slot0._btnlist, slot1 and slot0.compType == PlayerCardEnum.CompType.Normal)
end

function slot0.onDestroy(slot0)
	slot0._simageheadicon:UnLoadImage()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
