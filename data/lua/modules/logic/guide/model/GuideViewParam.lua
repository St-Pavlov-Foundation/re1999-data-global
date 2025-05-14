module("modules.logic.guide.model.GuideViewParam", package.seeall)

local var_0_0 = pureTable("GuideViewParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0.guideId = nil
	arg_1_0.stepId = nil
	arg_1_0.enableHoleClick = true
	arg_1_0.uiOffset = nil
	arg_1_0.goPath = nil
	arg_1_0.touchGOPath = nil
	arg_1_0.enableClick = true
	arg_1_0.enableDrag = false
	arg_1_0.enablePress = false
	arg_1_0.enableSpaceBtn = false
	arg_1_0.tipsPos = nil
	arg_1_0.tipsHead = nil
	arg_1_0.tipsTalker = nil
	arg_1_0.tipsContent = nil
	arg_1_0.hasTips = false
	arg_1_0.hasDialogue = false
	arg_1_0.storyContent = nil
	arg_1_0.hasStory = false
end

function var_0_0.setStep(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.guideId = arg_2_1
	arg_2_0.stepId = arg_2_2

	local var_2_0 = GuideConfig.instance:getStepCO(arg_2_1, arg_2_2)
	local var_2_1 = GuideModel.instance:getStepGOPath(arg_2_1, arg_2_2)

	arg_2_0:initUiType(var_2_0.uiInfo)
	arg_2_0:setUiOffset(var_2_0.uiOffset)
	arg_2_0:setGoPath(var_2_1)

	arg_2_0.touchGOPath = var_2_0.touchGOPath
	arg_2_0.tipsPos = string.splitToNumber(var_2_0.tipsPos, "#")
	arg_2_0.tipsHead = var_2_0.tipsHead
	arg_2_0.tipsTalker = var_2_0.tipsTalker
	arg_2_0.tipsContent = var_2_0.tipsContent
	arg_2_0.tipsDir = var_2_0.tipsDir

	if not string.nilorempty(arg_2_0.tipsContent) then
		arg_2_0.hasTips = not string.nilorempty(var_2_0.tipsPos)
	else
		arg_2_0.hasTips = false
		arg_2_0.hasDialogue = false
	end

	arg_2_0.portraitPos = var_2_0.portraitPos
	arg_2_0.storyContent = var_2_0.storyContent
	arg_2_0.hasStory = not string.nilorempty(arg_2_0.storyContent)
	arg_2_0.otherMasks = arg_2_0:getOtherMasks(var_2_0)
	arg_2_0.hasAnyTouchAction = arg_2_0:hasAction(var_2_0.action, 212)
end

function var_0_0.getOtherMasks(arg_3_0, arg_3_1)
	if arg_3_1.maskId > 0 then
		local var_3_0 = lua_guide_mask.configDict[arg_3_1.maskId]

		if not var_3_0 then
			return
		end

		local var_3_1 = {}

		for iter_3_0 = 1, 4 do
			local var_3_2 = var_3_0["uiOffset" .. iter_3_0]
			local var_3_3 = var_3_0["uiInfo" .. iter_3_0]
			local var_3_4 = var_3_0["goPath" .. iter_3_0]

			if not string.nilorempty(var_3_3) and not string.nilorempty(var_3_4) then
				local var_3_5 = {
					uiInfo = arg_3_0:getUiTypeParam(var_3_3),
					goPath = var_3_4,
					uiOffset = string.splitToNumber(var_3_2, "#")
				}

				table.insert(var_3_1, var_3_5)
			end
		end

		return #var_3_1 > 0 and var_3_1
	end
end

function var_0_0.hasAction(arg_4_0, arg_4_1, arg_4_2)
	if string.nilorempty(arg_4_1) == false then
		local var_4_0 = GameUtil.splitString2(arg_4_1, true, "|", "#")

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if iter_4_1[1] == arg_4_2 then
				return true
			end
		end
	end

	return false
end

function var_0_0.setGoPath(arg_5_0, arg_5_1)
	arg_5_0.goPath = arg_5_1
end

function var_0_0.setUiOffset(arg_6_0, arg_6_1)
	arg_6_0.uiOffset = string.splitToNumber(arg_6_1, "#")
end

function var_0_0.initUiType(arg_7_0, arg_7_1)
	arg_7_0.uiInfo = arg_7_0:getUiTypeParam(arg_7_1)
	arg_7_0.showMask = arg_7_0.uiInfo.maskAlpha ~= 0
end

function var_0_0.getUiTypeParam(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = string.splitToNumber(arg_8_1, "#")

	var_8_0.uiType = var_8_1[1]
	var_8_0.width = 0
	var_8_0.height = 0

	local var_8_2
	local var_8_3

	if var_8_0.uiType == GuideEnum.uiTypeCircle then
		var_8_0.width = var_8_1[2]
		var_8_0.height = var_8_1[2]
		var_8_3 = var_8_1[3]
		var_8_2 = var_8_1[4]
	elseif var_8_0.uiType == GuideEnum.uiTypeRectangle then
		var_8_0.width = var_8_1[2]
		var_8_0.height = var_8_1[3]
		var_8_3 = var_8_1[4]
		var_8_2 = var_8_1[5]
	elseif var_8_0.uiType == GuideEnum.uiTypeNoHole then
		var_8_3 = var_8_1[2] or 0.2
		var_8_2 = 0
	elseif var_8_0.uiType == GuideEnum.uiTypeDragCard or var_8_0.uiType == GuideEnum.uiTypeDragCard2 then
		var_8_3 = var_8_1[2]
	elseif var_8_0.uiType == GuideEnum.uiTypeArrow or var_8_0.uiType == GuideEnum.uiTypePressArrow then
		local var_8_4 = var_8_1[2] or 1

		var_8_0.rotation = GuideEnum.ArrowRotation[var_8_4]
		var_8_0.width = var_8_1[3] or 0
		var_8_0.height = var_8_1[4] or 0
		var_8_0.arrowOffsetX = var_8_1[5] or 0
		var_8_0.arrowOffsetY = var_8_1[6] or 0
		var_8_3 = var_8_1[7]
		var_8_2 = var_8_1[8]
	end

	var_8_0.maskAlpha = var_8_3 or 0
	var_8_0.imgAlpha = var_8_2 or 0
	var_8_0.stepId = arg_8_0.stepId
	var_8_0.guideId = arg_8_0.guideId

	return var_8_0
end

function var_0_0.setHole(arg_9_0)
	return
end

function var_0_0.setTips(arg_10_0)
	return
end

function var_0_0.setStory(arg_11_0)
	return
end

return var_0_0
