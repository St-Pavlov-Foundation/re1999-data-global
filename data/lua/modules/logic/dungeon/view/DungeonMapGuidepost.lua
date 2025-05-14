module("modules.logic.dungeon.view.DungeonMapGuidepost", package.seeall)

local var_0_0 = class("DungeonMapGuidepost", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0._scene = arg_4_1
end

function var_0_0.setConfig(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._config = arg_5_1
	arg_5_0._episodeId = arg_5_2

	if not string.nilorempty(arg_5_0._config.pos) then
		local var_5_0 = string.splitToNumber(arg_5_0._config.pos, "#")

		transformhelper.setLocalPos(arg_5_0.viewGO.transform, var_5_0[1], var_5_0[2], -5)
	end

	local var_5_1 = DungeonConfig.instance:getElementList(arg_5_2)
	local var_5_2 = string.splitToNumber(var_5_1, "#")

	for iter_5_0 = 1, 3 do
		local var_5_3 = var_5_2[iter_5_0]
		local var_5_4 = arg_5_0._goList[iter_5_0]

		gohelper.setActive(var_5_4, var_5_3)

		if var_5_3 then
			local var_5_5 = var_5_4:GetComponent(typeof(UnityEngine.Renderer))
			local var_5_6 = gohelper.findChild(var_5_4, "click")
			local var_5_7 = var_5_5.material
			local var_5_8 = DungeonMapModel.instance:elementIsFinished(var_5_3)

			if var_5_8 then
				var_5_7:SetColor("_MainCol", GameUtil.parseColor("#c66030ff"))
			else
				var_5_7:SetColor("_MainCol", GameUtil.parseColor("#ffffff99"))
			end

			gohelper.setActive(var_5_6, var_5_8)

			local var_5_9 = lua_chapter_map_element.configDict[var_5_3]
			local var_5_10 = var_5_7:GetVector("_Frame")

			var_5_10.w = DungeonEnum.ElementTypeIconIndex[string.format("%s", var_5_9.type .. (var_5_8 and 1 or 0))]

			var_5_7:SetVector("_Frame", var_5_10)
		end
	end
end

function var_0_0.allElementsFinished(arg_6_0)
	local var_6_0 = DungeonConfig.instance:getElementList(arg_6_0)
	local var_6_1 = string.splitToNumber(var_6_0, "#")

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if not DungeonMapModel.instance:elementIsFinished(iter_6_1) then
			return false
		end
	end

	return true
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goList = arg_7_0:getUserDataTb_()

	arg_7_0:_initElementGo(gohelper.findChild(arg_7_0.viewGO, "ani/plane_a"))
	arg_7_0:_initElementGo(gohelper.findChild(arg_7_0.viewGO, "ani/plane_b"))
	arg_7_0:_initElementGo(gohelper.findChild(arg_7_0.viewGO, "ani/plane_c"))
end

function var_0_0._initElementGo(arg_8_0, arg_8_1)
	table.insert(arg_8_0._goList, arg_8_1)
	DungeonMapElement.addBoxColliderListener(arg_8_1, arg_8_0._onDown, arg_8_0)
end

function var_0_0._onDown(arg_9_0)
	if arg_9_0._scene:showInteractiveItem() then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.Guidepost) then
		return
	end

	DungeonController.instance:openDungeonMapTaskView({
		viewParam = arg_9_0._episodeId
	})
end

function var_0_0.init(arg_10_0, arg_10_1)
	arg_10_0.viewGO = arg_10_1

	arg_10_0:onInitView()
	arg_10_0:addEvents()
	arg_10_0:_editableAddEvents()
end

function var_0_0._editableAddEvents(arg_11_0)
	return
end

function var_0_0._editableRemoveEvents(arg_12_0)
	return
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:removeEvents()
	arg_13_0:_editableRemoveEvents()
end

return var_0_0
