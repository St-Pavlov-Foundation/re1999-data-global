module("modules.logic.rouge.view.comp.RougeCapacityComp", package.seeall)

local var_0_0 = class("RougeCapacityComp", LuaCompBase)

var_0_0.SpriteType1 = "rouge_team_volume_1"
var_0_0.SpriteType2 = "rouge_team_volume_2"
var_0_0.SpriteType3 = "rouge_team_volume_3"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
end

function var_0_0.Add(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0, var_0_0)

	var_2_0:setCurNum(arg_2_1)
	var_2_0:setMaxNum(arg_2_2)

	if arg_2_3 then
		var_2_0:autoFindNodes()
	end

	var_2_0:setSpriteType(nil, arg_2_4)
	var_2_0:initCapacity()

	return var_2_0
end

function var_0_0.getCurNum(arg_3_0)
	return arg_3_0._curNum
end

function var_0_0.getMaxNum(arg_4_0)
	return arg_4_0._maxNum
end

function var_0_0.updateCurAndMaxNum(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._curNum = arg_5_1
	arg_5_0._maxNum = arg_5_2

	arg_5_0:_refreshImageList()
end

function var_0_0.updateCurNum(arg_6_0, arg_6_1)
	arg_6_0._curNum = arg_6_1

	arg_6_0:_refreshImageList()
end

function var_0_0.updateMaxNum(arg_7_0, arg_7_1)
	arg_7_0._maxNum = arg_7_1

	arg_7_0:_refreshImageList()
end

function var_0_0.updateMaxNumAndOpaqueNum(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._opaqueNum = arg_8_2

	arg_8_0:updateMaxNum(arg_8_1)
end

function var_0_0.showChangeEffect(arg_9_0, arg_9_1)
	arg_9_0._showChangeEffect = arg_9_1
end

function var_0_0.setPoint(arg_10_0, arg_10_1)
	arg_10_0._pointGo = arg_10_1
end

function var_0_0.setTxt(arg_11_0, arg_11_1)
	arg_11_0._txt = arg_11_1
end

function var_0_0.autoFindNodes(arg_12_0)
	arg_12_0._pointGo = gohelper.findChild(arg_12_0._go, "point")

	gohelper.setActive(arg_12_0._pointGo, false)

	arg_12_0._txt = gohelper.findChildText(arg_12_0._go, "#txt_num")

	if not arg_12_0._pointGo then
		logError("RougeCapacityComp autoFindNodes 请检查脚本是否attach在volume上，以及节点目录是否正确")
	end
end

function var_0_0.setCurNum(arg_13_0, arg_13_1)
	if arg_13_0._curNum then
		return
	end

	arg_13_0._curNum = arg_13_1
end

function var_0_0.setMaxNum(arg_14_0, arg_14_1)
	if arg_14_0._maxNum then
		return
	end

	arg_14_0._maxNum = arg_14_1
end

function var_0_0.setSpriteType(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._usedSpriteType = arg_15_1
	arg_15_0._notUsedSpriteType = arg_15_2
end

function var_0_0.getUsedSpriteType(arg_16_0)
	arg_16_0._usedSpriteType = arg_16_0._usedSpriteType or var_0_0.SpriteType3

	return arg_16_0._usedSpriteType
end

function var_0_0.getNotUsedSpriteType(arg_17_0)
	arg_17_0._notUsedSpriteType = arg_17_0._notUsedSpriteType or var_0_0.SpriteType1

	return arg_17_0._notUsedSpriteType
end

function var_0_0.setTxtFormat(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._notFullFormat = arg_18_1
	arg_18_0._fullFormat = arg_18_2
end

function var_0_0.getFullFormat(arg_19_0)
	arg_19_0._fullFormat = arg_19_0._fullFormat or "<#D97373>%s</color>/%s"

	return arg_19_0._fullFormat
end

function var_0_0.getNotFullFormat(arg_20_0)
	arg_20_0._notFullFormat = arg_20_0._notFullFormat or "<#E99B56>%s</color>/%s"

	return arg_20_0._notFullFormat
end

function var_0_0.initCapacity(arg_21_0)
	if arg_21_0._imageList then
		return
	end

	arg_21_0._imageList = arg_21_0:getUserDataTb_()

	arg_21_0:_refreshImageList()
end

function var_0_0._getPointInfo(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._imageList[arg_22_1]

	if not var_22_0 then
		local var_22_1 = gohelper.cloneInPlace(arg_22_0._pointGo)

		gohelper.setActive(var_22_1, true)

		local var_22_2 = var_22_1:GetComponent(gohelper.Type_Image)

		var_22_0 = arg_22_0:getUserDataTb_()
		arg_22_0._imageList[arg_22_1] = var_22_0
		var_22_0.image = var_22_2
		var_22_0.yellow = gohelper.findChild(var_22_1, "yellow")
	end

	return var_22_0
end

function var_0_0._refreshImageList(arg_23_0)
	if not arg_23_0._imageList or not arg_23_0._maxNum then
		return
	end

	local var_23_0 = false
	local var_23_1 = arg_23_0._curNum or 0
	local var_23_2 = var_23_1 ~= arg_23_0._prevNum

	arg_23_0._prevNum = var_23_1

	local var_23_3 = arg_23_0._maxNum
	local var_23_4 = arg_23_0._opaqueNum or var_23_3
	local var_23_5 = math.max(var_23_3, #arg_23_0._imageList)

	for iter_23_0 = 1, var_23_5 do
		local var_23_6 = arg_23_0:_getPointInfo(iter_23_0)
		local var_23_7 = var_23_6.image
		local var_23_8 = iter_23_0 <= arg_23_0._maxNum

		gohelper.setActive(var_23_7, var_23_8)

		if var_23_8 then
			local var_23_9 = iter_23_0 <= var_23_1

			if var_23_9 and arg_23_0._showChangeEffect and var_23_2 then
				gohelper.setActive(var_23_6.yellow, false)
				gohelper.setActive(var_23_6.yellow, true)

				var_23_0 = true
			end

			UISpriteSetMgr.instance:setRougeSprite(var_23_7, var_23_9 and arg_23_0:getUsedSpriteType() or arg_23_0:getNotUsedSpriteType())

			if arg_23_0._opaqueNum ~= nil then
				local var_23_10 = var_23_7.color

				var_23_10.a = iter_23_0 <= var_23_4 and 1 or 0.4
				var_23_7.color = var_23_10
			end
		end
	end

	if var_23_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.PointLight)
	end

	if arg_23_0._txt then
		local var_23_11 = var_23_1 >= arg_23_0._maxNum and arg_23_0:getFullFormat() or arg_23_0:getNotFullFormat()

		arg_23_0._txt.text = string.format(var_23_11, var_23_1, arg_23_0._maxNum)
	end
end

return var_0_0
