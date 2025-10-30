module("modules.logic.commandstation.view.CommandStationMapLeftVersionView", package.seeall)

local var_0_0 = class("CommandStationMapLeftVersionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonameViewport = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport")
	arg_1_0._gonameContent = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent")
	arg_1_0._gonameItem = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/ScrollView/#go_leftViewport/#go_leftContent/#go_versionItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	gohelper.setActive(arg_2_0._gonameItem, false)

	arg_2_0._itemList = arg_2_0:getUserDataTb_()
	arg_2_0._recycleList = arg_2_0:getUserDataTb_()
	arg_2_0._versionConfigList = lua_copost_version.configList
	arg_2_0._versionConfigLen = #arg_2_0._versionConfigList
	arg_2_0._itemHeight = 60
	arg_2_0._itemSpace = 0
	arg_2_0._itemHeightWithSpace = arg_2_0._itemHeight + arg_2_0._itemSpace
	arg_2_0._halfItemHeight = arg_2_0._itemHeight / 2
	arg_2_0._startIndex = -1
	arg_2_0._endIndex = 3
	arg_2_0._noScaleOffsetIndex = 2
end

function var_0_0._checkBoundry(arg_3_0)
	local var_3_0 = recthelper.getAnchorY(arg_3_0._gonameContent.transform)
	local var_3_1 = Mathf.Round(var_3_0 / arg_3_0._itemHeightWithSpace)
	local var_3_2 = arg_3_0._startIndex + var_3_1
	local var_3_3 = arg_3_0._endIndex + var_3_1
	local var_3_4 = var_3_2 + arg_3_0._noScaleOffsetIndex
	local var_3_5 = -180

	for iter_3_0, iter_3_1 in pairs(arg_3_0._itemList) do
		if var_3_2 > iter_3_1.index or var_3_3 < iter_3_1.index then
			gohelper.setActive(iter_3_1.go, false)

			arg_3_0._itemList[iter_3_0] = nil

			table.insert(arg_3_0._recycleList, iter_3_1)
		end
	end

	for iter_3_2 = var_3_2, var_3_3 do
		if not arg_3_0._itemList[iter_3_2] then
			local var_3_6 = arg_3_0:_getItem(iter_3_2)

			arg_3_0._itemList[iter_3_2] = var_3_6
		end

		local var_3_7 = arg_3_0._itemList[iter_3_2]
		local var_3_8 = recthelper.getAnchorY(var_3_7.transform) + var_3_0 + arg_3_0._halfItemHeight
		local var_3_9 = math.abs(var_3_8 - var_3_5) * 0.1 / arg_3_0._itemHeight

		transformhelper.setLocalScale(var_3_7.transform, 1 - var_3_9, 1 - var_3_9, 1)
	end

	return var_3_4
end

function var_0_0._getItem(arg_4_0, arg_4_1)
	local var_4_0 = table.remove(arg_4_0._recycleList)

	if not var_4_0 then
		local var_4_1 = gohelper.cloneInPlace(arg_4_0._gonameItem)
		local var_4_2 = gohelper.findChildText(var_4_1, "Text")

		var_4_0 = {
			transform = var_4_1.transform,
			go = var_4_1,
			txt = var_4_2
		}
	end

	var_4_0.index = arg_4_1

	local var_4_3 = math.abs(arg_4_1 % #arg_4_0._versionConfigList)
	local var_4_4 = arg_4_0._versionConfigList[var_4_3 + 1]

	var_4_0.txt.text = var_4_4.id

	recthelper.setAnchorY(var_4_0.transform, -arg_4_1 * arg_4_0._itemHeightWithSpace - arg_4_0._halfItemHeight)
	gohelper.setActive(var_4_0.go, true)

	var_4_0.go.name = arg_4_1

	return var_4_0
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0._startIndex + arg_5_0._noScaleOffsetIndex
	local var_5_1 = math.abs(var_5_0 % arg_5_0._versionConfigLen)
	local var_5_2 = arg_5_0._versionConfigList[var_5_1 + 1].versionId
	local var_5_3 = CommandStationMapModel.instance:getVersionId()

	if var_5_3 ~= var_5_2 then
		arg_5_0._focusVersionPosY = (CommandStationConfig.instance:getVersionIndex(var_5_3) - 1 - var_5_1) * arg_5_0._itemHeightWithSpace

		recthelper.setAnchorY(arg_5_0._gonameContent.transform, arg_5_0._focusVersionPosY)
	else
		arg_5_0._focusVersionPosY = 0

		recthelper.setAnchorY(arg_5_0._gonameContent.transform, arg_5_0._focusVersionPosY)
	end

	arg_5_0:_checkBoundry()
end

function var_0_0.setContentPosY(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._focusVersionPosY + (arg_6_1 + arg_6_2) * arg_6_0._itemHeightWithSpace

	recthelper.setAnchorY(arg_6_0._gonameContent.transform, var_6_0)

	local var_6_1 = math.abs(arg_6_2)

	if arg_6_0._lastRation and arg_6_0._lastRation < 0.3 and var_6_1 >= 0.3 then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_common_click)
	end

	arg_6_0._lastRation = var_6_1

	arg_6_0:_checkBoundry()
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0._tweenId then
		ZProj.TweenHelper.KillById(arg_7_0._tweenId)

		arg_7_0._tweenId = nil
	end
end

return var_0_0
