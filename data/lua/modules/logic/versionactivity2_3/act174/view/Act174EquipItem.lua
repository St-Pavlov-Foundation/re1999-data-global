module("modules.logic.versionactivity2_3.act174.view.Act174EquipItem", package.seeall)

local var_0_0 = class("Act174EquipItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._teamView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._imageQuality = gohelper.findChildImage(arg_2_1, "image_quality")
	arg_2_0._simageCollection = gohelper.findChildSingleImage(arg_2_1, "simage_Collection")
	arg_2_0._goEmpty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0._click = gohelper.findChildClick(arg_2_1, "")

	CommonDragHelper.instance:registerDragObj(arg_2_1, arg_2_0.beginDrag, nil, arg_2_0.endDrag, arg_2_0.checkDrag, arg_2_0)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._click:AddClickListener(arg_3_0.onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._click:RemoveClickListener()
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0._simageCollection:UnLoadImage()
	CommonDragHelper.instance:unregisterDragObj(arg_5_0._go)
end

function var_0_0.setIndex(arg_6_0, arg_6_1)
	arg_6_0._index = arg_6_1

	local var_6_0 = arg_6_0._teamView.unLockTeamCnt
	local var_6_1 = Activity174Helper.CalculateRowColumn(arg_6_1)

	gohelper.setActive(arg_6_0._go, var_6_1 <= var_6_0)
end

function var_0_0.setData(arg_7_0, arg_7_1)
	arg_7_0._collectionId = arg_7_1

	if arg_7_1 then
		local var_7_0 = lua_activity174_collection.configDict[arg_7_1]

		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageQuality, "act174_propitembg_" .. var_7_0.rare)
		arg_7_0._simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(var_7_0.icon))
	else
		arg_7_0._simageCollection:UnLoadImage()
	end

	gohelper.setActive(arg_7_0._imageQuality, arg_7_1)
	gohelper.setActive(arg_7_0._simageCollection, arg_7_1)
	gohelper.setActive(arg_7_0._goEmpty, not arg_7_1)
end

function var_0_0.onClick(arg_8_0)
	if arg_8_0.tweenId or arg_8_0.isDraging then
		return
	end

	arg_8_0._teamView:clickCollection(arg_8_0._index)
end

function var_0_0.beginDrag(arg_9_0)
	gohelper.setAsLastSibling(arg_9_0._go)

	arg_9_0.isDraging = true
end

function var_0_0.endDrag(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.isDraging = false

	local var_10_0 = arg_10_2.position
	local var_10_1 = arg_10_0:findTarget(var_10_0)

	if not var_10_1 then
		local var_10_2 = arg_10_0._teamView.frameTrList[arg_10_0._index]
		local var_10_3, var_10_4 = recthelper.getAnchor(var_10_2)

		arg_10_0:setToPos(arg_10_0._go.transform, Vector2(var_10_3, var_10_4), true, arg_10_0.tweenCallback, arg_10_0)
		arg_10_0._teamView:UnInstallCollection(arg_10_0._index)
	else
		local var_10_5 = arg_10_0._index
		local var_10_6 = var_10_1._index

		if arg_10_0._teamView:canEquipMove(var_10_5, var_10_6) then
			local var_10_7 = arg_10_0._teamView.frameTrList[var_10_6]
			local var_10_8, var_10_9 = recthelper.getAnchor(var_10_7)

			arg_10_0:setToPos(arg_10_0._go.transform, Vector2(var_10_8, var_10_9), true, arg_10_0.tweenCallback, arg_10_0)

			if var_10_1 ~= arg_10_0 then
				local var_10_10 = arg_10_0._teamView.frameTrList[arg_10_0._index]
				local var_10_11, var_10_12 = recthelper.getAnchor(var_10_10)

				arg_10_0:setToPos(var_10_1._go.transform, Vector2(var_10_11, var_10_12), true, function()
					arg_10_0._teamView:exchangeEquipItem(arg_10_0._index, var_10_6)
				end, arg_10_0)
			end
		else
			GameFacade.showToast(ToastEnum.Act174OnlyCollection)

			local var_10_13 = arg_10_0._teamView.frameTrList[arg_10_0._index]
			local var_10_14, var_10_15 = recthelper.getAnchor(var_10_13)

			arg_10_0:setToPos(arg_10_0._go.transform, Vector2(var_10_14, var_10_15), true, arg_10_0.tweenCallback, arg_10_0)
		end
	end
end

function var_0_0.checkDrag(arg_12_0)
	if arg_12_0._collectionId and arg_12_0._collectionId ~= 0 then
		return false
	end

	return true
end

function var_0_0.findTarget(arg_13_0, arg_13_1)
	for iter_13_0 = 1, arg_13_0._teamView.unLockTeamCnt * 4 do
		local var_13_0 = arg_13_0._teamView.frameTrList[iter_13_0]
		local var_13_1 = arg_13_0._teamView.equipItemList[iter_13_0]
		local var_13_2, var_13_3 = recthelper.getAnchor(var_13_0)
		local var_13_4 = var_13_0.parent
		local var_13_5 = recthelper.screenPosToAnchorPos(arg_13_1, var_13_4)

		if math.abs(var_13_5.x - var_13_2) * 2 < recthelper.getWidth(var_13_0) and math.abs(var_13_5.y - var_13_3) * 2 < recthelper.getHeight(var_13_0) then
			return var_13_1 or nil
		end
	end

	return nil
end

function var_0_0.setToPos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_3 then
		CommonDragHelper.instance:setGlobalEnabled(false)

		arg_14_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_14_1, arg_14_2.x, arg_14_2.y, 0.2, arg_14_4, arg_14_5)
	else
		recthelper.setAnchor(arg_14_1, arg_14_2.x, arg_14_2.y)

		if arg_14_4 then
			arg_14_4(arg_14_5)
		end
	end
end

function var_0_0.tweenCallback(arg_15_0)
	arg_15_0.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return var_0_0
