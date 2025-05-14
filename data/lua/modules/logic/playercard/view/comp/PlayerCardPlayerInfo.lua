module("modules.logic.playercard.view.comp.PlayerCardPlayerInfo", package.seeall)

local var_0_0 = class("PlayerCardPlayerInfo", BaseView)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	arg_1_0:onInitView()
end

function var_0_0.canOpen(arg_2_0)
	arg_2_0:onOpen()
	arg_2_0:addEvents()
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0.go = gohelper.findChild(arg_3_0.viewGO, "root/main/playerinfo")
	arg_3_0._simageheadicon = gohelper.findChildSingleImage(arg_3_0.go, "ani/headframe/#simage_headicon")
	arg_3_0._btnheadicon = gohelper.findChildButtonWithAudio(arg_3_0.go, "ani/headframe/#simage_headicon")
	arg_3_0._goframenode = gohelper.findChild(arg_3_0.go, "ani/headframe/#simage_headicon/#go_framenode")
	arg_3_0._txtlevel = gohelper.findChildText(arg_3_0.go, "ani/lv/#txt_level")
	arg_3_0._txtplayerid = gohelper.findChildText(arg_3_0.go, "ani/#txt_playerid")
	arg_3_0._btnplayerid = gohelper.findChildButtonWithAudio(arg_3_0.go, "ani/#txt_playerid/#btn_playerid")
	arg_3_0._txtname = gohelper.findChildText(arg_3_0.go, "ani/#txt_name")
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnplayerid:AddClickListener(arg_4_0._btnplayeridOnClick, arg_4_0)
	arg_4_0._btnheadicon:AddClickListener(arg_4_0._changeIcon, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, arg_4_0.onRefreshView, arg_4_0)
	arg_4_0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, arg_4_0.onRefreshView, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnplayerid:RemoveClickListener()
	arg_5_0._btnheadicon:RemoveClickListener()
end

function var_0_0._changeIcon(arg_6_0)
	if arg_6_0:isPlayerSelf() then
		ViewMgr.instance:openView(ViewName.IconTipView)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.userId = arg_7_0.viewParam.userId

	arg_7_0:updateBaseInfo()
end

function var_0_0.getCardInfo(arg_8_0)
	return PlayerCardModel.instance:getCardInfo(arg_8_0.userId)
end

function var_0_0.isPlayerSelf(arg_9_0)
	local var_9_0 = arg_9_0:getCardInfo()

	return var_9_0 and var_9_0:isSelf()
end

function var_0_0.getPlayerInfo(arg_10_0)
	local var_10_0 = arg_10_0:getCardInfo()

	return var_10_0 and var_10_0:getPlayerInfo()
end

function var_0_0._btnplayeridOnClick(arg_11_0)
	local var_11_0 = arg_11_0:getPlayerInfo()

	if not var_11_0 then
		return
	end

	arg_11_0._txtplayerid.text = var_11_0.userId

	ZProj.UGUIHelper.CopyText(arg_11_0._txtplayerid.text)

	arg_11_0._txtplayerid.text = string.format("ID:%s", var_11_0.userId)

	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function var_0_0.onRefreshView(arg_12_0)
	arg_12_0:updateBaseInfo()
end

function var_0_0.updateBaseInfo(arg_13_0)
	local var_13_0 = arg_13_0:getPlayerInfo()

	if not var_13_0 then
		return
	end

	arg_13_0._txtname.text = var_13_0.name
	arg_13_0._txtplayerid.text = string.format("ID:%s", var_13_0.userId)
	arg_13_0._txtlevel.text = var_13_0.level

	local var_13_1 = lua_item.configDict[var_13_0.portrait]

	if not arg_13_0._liveHeadIcon then
		arg_13_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_13_0._simageheadicon)
	end

	arg_13_0._liveHeadIcon:setLiveHead(var_13_0.portrait)

	local var_13_2 = string.split(var_13_1.effect, "#")

	if #var_13_2 > 1 then
		if var_13_1.id == tonumber(var_13_2[#var_13_2]) then
			gohelper.setActive(arg_13_0._goframenode, true)

			if not arg_13_0.frame and not arg_13_0._loader then
				arg_13_0._loader = MultiAbLoader.New()

				local var_13_3 = "ui/viewres/common/effect/frame.prefab"

				arg_13_0._loader:addPath(var_13_3)
				arg_13_0._loader:startLoad(arg_13_0._onLoadCallback, arg_13_0)
			end
		end
	else
		gohelper.setActive(arg_13_0._goframenode, false)
	end
end

function var_0_0._onLoadCallback(arg_14_0)
	local var_14_0 = arg_14_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_14_0, arg_14_0._goframenode, "frame")

	arg_14_0.frame = gohelper.findChild(arg_14_0._goframenode, "frame")
	arg_14_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_14_1 = 1.41 * (recthelper.getWidth(arg_14_0._simageheadicon.transform) / recthelper.getWidth(arg_14_0.frame.transform))

	transformhelper.setLocalScale(arg_14_0.frame.transform, var_14_1, var_14_1, 1)
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0._simageheadicon:UnLoadImage()

	if arg_15_0._loader then
		arg_15_0._loader:dispose()

		arg_15_0._loader = nil
	end

	arg_15_0:removeEvents()
end

return var_0_0
