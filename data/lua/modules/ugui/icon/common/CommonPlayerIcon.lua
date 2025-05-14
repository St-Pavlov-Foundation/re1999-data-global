module("modules.ugui.icon.common.CommonPlayerIcon", package.seeall)

local var_0_0 = class("CommonPlayerIcon", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._simageheadicon = gohelper.findChildSingleImage(arg_1_0.go, "bg/#simage_headicon")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.go, "bg/#simage_headicon/#go_framenode")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.go, "#go_level")
	arg_1_0._imgLevelbg = gohelper.findChildImage(arg_1_0.go, "#go_level")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.go, "#go_level/#txt_level")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_click")
	arg_1_0._loader = MultiAbLoader.New()
	arg_1_0._enableClick = true
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.setEnableClick(arg_4_0, arg_4_1)
	arg_4_0._enableClick = arg_4_1
end

function var_0_0.isSelectInFriend(arg_5_0, arg_5_1)
	arg_5_0._isSelectInFriend = arg_5_1
end

function var_0_0.setPlayerIconGray(arg_6_0, arg_6_1)
	arg_6_0._liveHeadIcon:setGray(arg_6_1)
end

function var_0_0.setScale(arg_7_0, arg_7_1)
	transformhelper.setLocalScale(arg_7_0.tr, arg_7_1, arg_7_1, arg_7_1)
end

function var_0_0.setPos(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0[arg_8_1] then
		return
	end

	recthelper.setAnchor(arg_8_0[arg_8_1].transform, arg_8_2, arg_8_3)
end

function var_0_0._onClick(arg_9_0)
	if not arg_9_0._enableClick then
		return
	end

	local var_9_0 = arg_9_0._simageheadicon.transform.position
	local var_9_1 = {
		mo = arg_9_0._mo,
		worldPos = var_9_0
	}

	if arg_9_0._isSelectInFriend then
		var_9_1.isSelectInFriend = arg_9_0._isSelectInFriend
	end

	ViewMgr.instance:openView(ViewName.PlayerInfoView, var_9_1)
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0._txtlevel.text = "Lv." .. arg_10_0._mo.level

	if not arg_10_0._liveHeadIcon then
		arg_10_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_10_0._simageheadicon)
	end

	arg_10_0._liveHeadIcon:setLiveHead(arg_10_0._mo.portrait)

	local var_10_0 = PlayerModel.instance:getMyUserId()

	if arg_10_0._mo.userId == var_10_0 then
		arg_10_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, arg_10_0._changePlayerinfo, arg_10_0)
	else
		arg_10_0:removeEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, arg_10_0._changePlayerinfo, arg_10_0)
	end
end

function var_0_0._onLoadCallback(arg_11_0)
	arg_11_0.isloading = false

	local var_11_0 = arg_11_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_11_0, arg_11_0._goframenode, "frame")

	arg_11_0.frame = gohelper.findChild(arg_11_0._goframenode, "frame")
	arg_11_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_11_1 = 1.41 * (recthelper.getWidth(arg_11_0._simageheadicon.transform) / recthelper.getWidth(arg_11_0.frame.transform))

	transformhelper.setLocalScale(arg_11_0.frame.transform, var_11_1, var_11_1, 1)
end

function var_0_0._changePlayerinfo(arg_12_0)
	arg_12_0._mo = SocialModel.instance:getPlayerMO(arg_12_0._mo.userId)

	arg_12_0:_refreshUI()
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._mo = arg_13_1

	arg_13_0:_refreshUI()
	arg_13_0:refreshFrame()
end

function var_0_0.refreshFrame(arg_14_0)
	local var_14_0 = lua_item.configDict[arg_14_0._mo.portrait]
	local var_14_1 = string.split(var_14_0.effect, "#")

	if #var_14_1 > 1 then
		if var_14_0.id == tonumber(var_14_1[#var_14_1]) then
			gohelper.setActive(arg_14_0._goframenode, true)

			if not arg_14_0.frame and not arg_14_0.isloading then
				arg_14_0.isloading = true

				local var_14_2 = "ui/viewres/common/effect/frame.prefab"

				arg_14_0._loader:addPath(var_14_2)
				arg_14_0._loader:startLoad(arg_14_0._onLoadCallback, arg_14_0)
			end
		end
	else
		gohelper.setActive(arg_14_0._goframenode, false)
	end
end

function var_0_0.setMOValue(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	local var_15_0 = {
		userId = arg_15_1,
		name = arg_15_2,
		level = arg_15_3,
		portrait = arg_15_4,
		time = arg_15_5,
		bg = arg_15_6
	}

	arg_15_0._mo = SocialPlayerMO.New()

	arg_15_0._mo:init(var_15_0)
	arg_15_0:_refreshUI()
	arg_15_0:setShowLevel(true)
end

function var_0_0.setShowLevel(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._golevel, arg_16_1)
end

function var_0_0.getLevelBg(arg_17_0)
	return arg_17_0._imgLevelbg
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0._simageheadicon:UnLoadImage()

	arg_18_0._simageheadicon = nil

	if arg_18_0._loader then
		arg_18_0._loader:dispose()

		arg_18_0._loader = nil
	end
end

return var_0_0
