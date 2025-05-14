module("modules.logic.act201.view.TurnBackFullViewFriendItem", package.seeall)

local var_0_0 = class("TurnBackFullViewFriendItem", RougeSimpleItemBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0._txtName = gohelper.findChildTextMesh(arg_3_0.viewGO, "invited/namebg/#txt_name")
	arg_3_0._goInvited = gohelper.findChild(arg_3_0.viewGO, "invited")
	arg_3_0._goUnInvite = gohelper.findChild(arg_3_0.viewGO, "uninvite")
	arg_3_0._simgHeadIcon = gohelper.findChildSingleImage(arg_3_0.viewGO, "invited/#go_playerheadicon")
	arg_3_0._goframenode = gohelper.findChild(arg_3_0.viewGO, "invited/#go_playerheadicon/#go_framenode")
	arg_3_0._txtstatetext = gohelper.findChildText(arg_3_0.viewGO, "invited/playerstate/#txt_statetext")
	arg_3_0._txtframenum1 = gohelper.findChildText(arg_3_0.viewGO, "uninvite/frame/#txt_framenum")
	arg_3_0._txtframenum2 = gohelper.findChildText(arg_3_0.viewGO, "invited/frame/#txt_framenum")
	arg_3_0._txtframenum1.text = ""
	arg_3_0._txtframenum2.text = ""
	arg_3_0._loader = MultiAbLoader.New()
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0._roleInfo = arg_4_1

	arg_4_0:_refreshItem()
end

function var_0_0.setEmpty(arg_5_0)
	arg_5_0:setInfoState(false)
	arg_5_0:_refreshItemNum()
end

function var_0_0.setInfoState(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goInvited, arg_6_1)
	gohelper.setActive(arg_6_0._goUnInvite, not arg_6_1)
end

function var_0_0._refreshItem(arg_7_0)
	local var_7_0 = arg_7_0._roleInfo

	if var_7_0 == nil then
		arg_7_0:setEmpty()

		return
	end

	arg_7_0:setInfoState(true)
	arg_7_0:_refreshItemNum()

	arg_7_0._txtName.text = var_7_0.name
	arg_7_0._txtstatetext.text = Activity201Config.instance:getRoleTypeStr(var_7_0.roleType)

	local var_7_1 = lua_item.configDict[var_7_0.portrait]

	if not arg_7_0._liveHeadIcon then
		arg_7_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_7_0._simgHeadIcon)
	end

	arg_7_0._liveHeadIcon:setLiveHead(var_7_1.id)

	local var_7_2 = string.split(var_7_1.effect, "#")

	if #var_7_2 > 1 then
		if var_7_1.id == tonumber(var_7_2[#var_7_2]) then
			gohelper.setActive(arg_7_0._goframenode, true)

			if not arg_7_0.frame then
				local var_7_3 = "ui/viewres/common/effect/frame.prefab"

				arg_7_0._loader:addPath(var_7_3)
				arg_7_0._loader:startLoad(arg_7_0._onLoadCallback, arg_7_0)
			end
		end
	else
		gohelper.setActive(arg_7_0._goframenode, false)
	end
end

function var_0_0._onLoadCallback(arg_8_0)
	local var_8_0 = arg_8_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_8_0, arg_8_0._goframenode, "frame")

	arg_8_0.frame = gohelper.findChild(arg_8_0._goframenode, "frame")
	arg_8_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_8_1 = 1.41 * (recthelper.getWidth(arg_8_0._simgHeadIcon.transform) / recthelper.getWidth(arg_8_0.frame.transform))

	transformhelper.setLocalScale(arg_8_0.frame.transform, var_8_1, var_8_1, 1)
end

function var_0_0.addEventListeners(arg_9_0)
	return
end

function var_0_0.removeEventListeners(arg_10_0)
	return
end

function var_0_0.destroy(arg_11_0)
	arg_11_0._simgHeadIcon:UnLoadImage()

	arg_11_0._roleInfo = nil

	arg_11_0:disposeLoader()
	arg_11_0:__onDispose()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0:destroy()
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:onDestroyView()
end

function var_0_0._refreshItemNum(arg_14_0)
	local var_14_0 = arg_14_0._index < 10 and "0" .. arg_14_0._index or arg_14_0._index

	arg_14_0._txtframenum1.text = var_14_0
	arg_14_0._txtframenum2.text = var_14_0
end

function var_0_0.disposeLoader(arg_15_0)
	if arg_15_0._loader then
		arg_15_0._loader:dispose()

		arg_15_0._loader = nil
	end
end

return var_0_0
