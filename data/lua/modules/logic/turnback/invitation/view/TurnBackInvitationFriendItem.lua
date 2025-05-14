module("modules.logic.turnback.invitation.view.TurnBackInvitationFriendItem", package.seeall)

local var_0_0 = class("TurnBackInvitationFriendItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0._txtName = gohelper.findChildTextMesh(arg_1_1, "invited/namebg/#txt_name")
	arg_1_0._goInvited = gohelper.findChild(arg_1_1, "invited")
	arg_1_0._goUnInvite = gohelper.findChild(arg_1_1, "uninvite")
	arg_1_0._simgHeadIcon = gohelper.findChildSingleImage(arg_1_1, "invited/#go_playerheadicon")
	arg_1_0._goframenode = gohelper.findChild(arg_1_1, "invited/#go_playerheadicon/#go_framenode")
	arg_1_0._loader = MultiAbLoader.New()
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0._roleInfo = arg_2_1

	arg_2_0:_refreshItem()
end

function var_0_0.setEmpty(arg_3_0)
	arg_3_0:setInfoState(false)
end

function var_0_0.setInfoState(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._goInvited, arg_4_1)
	gohelper.setActive(arg_4_0._goUnInvite, not arg_4_1)
end

function var_0_0._refreshItem(arg_5_0)
	local var_5_0 = arg_5_0._roleInfo

	if var_5_0 == nil then
		logError("Player Info is nil")
		arg_5_0:setEmpty()

		return
	end

	arg_5_0:setInfoState(true)

	arg_5_0._txtName.text = var_5_0.name

	local var_5_1 = lua_item.configDict[var_5_0.portrait]

	if not arg_5_0._liveHeadIcon then
		arg_5_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_5_0._simgHeadIcon)
	end

	arg_5_0._liveHeadIcon:setLiveHead(var_5_1.id)

	local var_5_2 = string.split(var_5_1.effect, "#")

	if #var_5_2 > 1 then
		if var_5_1.id == tonumber(var_5_2[#var_5_2]) then
			gohelper.setActive(arg_5_0._goframenode, true)

			if not arg_5_0.frame then
				local var_5_3 = "ui/viewres/common/effect/frame.prefab"

				arg_5_0._loader:addPath(var_5_3)
				arg_5_0._loader:startLoad(arg_5_0._onLoadCallback, arg_5_0)
			end
		end
	else
		gohelper.setActive(arg_5_0._goframenode, false)
	end
end

function var_0_0._onLoadCallback(arg_6_0)
	local var_6_0 = arg_6_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_6_0, arg_6_0._goframenode, "frame")

	arg_6_0.frame = gohelper.findChild(arg_6_0._goframenode, "frame")
	arg_6_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_6_1 = 1.41 * (recthelper.getWidth(arg_6_0._simgHeadIcon.transform) / recthelper.getWidth(arg_6_0.frame.transform))

	transformhelper.setLocalScale(arg_6_0.frame.transform, var_6_1, var_6_1, 1)
end

function var_0_0.addEventListeners(arg_7_0)
	return
end

function var_0_0.removeEventListeners(arg_8_0)
	return
end

function var_0_0.destroy(arg_9_0)
	arg_9_0:__onDispose()
	arg_9_0._simgHeadIcon:UnLoadImage()

	arg_9_0._roleInfo = nil
end

return var_0_0
