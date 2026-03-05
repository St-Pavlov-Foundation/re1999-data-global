-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapAttrCheckHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapAttrCheckHelper", package.seeall)

local Rouge2_MapAttrCheckHelper = class("Rouge2_MapAttrCheckHelper")

function Rouge2_MapAttrCheckHelper.onGetCheckResultMsg(msg)
	if not msg or not msg:HasField("checkInfo") then
		return
	end

	local checkResInfo = Rouge2_DiceCheckResInfoMO.New()

	checkResInfo:init(msg.checkInfo)
	Rouge2_MapAttrCheckHelper.triggerCheckResult(checkResInfo)
end

function Rouge2_MapAttrCheckHelper.triggerCheckResult(checkResInfo)
	if not checkResInfo then
		return
	end

	local checkType = Rouge2_MapEnum.AttrCheckType.ActiveRandom

	Rouge2_MapAttrCheckHelper._initInteractHandle()

	local handle = Rouge2_MapAttrCheckHelper.handleDict[checkType]

	if not handle then
		logError("not found interact type .. " .. tostring(checkType))

		return
	end

	handle(checkResInfo)
end

function Rouge2_MapAttrCheckHelper._initInteractHandle()
	if not Rouge2_MapAttrCheckHelper.handleDict then
		Rouge2_MapAttrCheckHelper.handleDict = {
			[Rouge2_MapEnum.AttrCheckType.ActiveRandom] = Rouge2_MapAttrCheckHelper.handleActiveRandom,
			[Rouge2_MapEnum.AttrCheckType.MiniGame] = Rouge2_MapAttrCheckHelper.handleMiniGame
		}
	end
end

function Rouge2_MapAttrCheckHelper.handleActiveRandom(checkResInfo)
	logNormal("主动属性检定")

	local params = {
		checkResInfo = checkResInfo
	}

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapDiceView, params)
end

function Rouge2_MapAttrCheckHelper.handleMiniGame(checkResInfo)
	logNormal("属性小游戏")
end

function Rouge2_MapAttrCheckHelper.formatCheckRate(checkRate)
	return string.format("%s%%", math.ceil(checkRate / 10))
end

function Rouge2_MapAttrCheckHelper.isChoiceAttrThreshold(choiceId)
	local choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(choiceId)
	local attrThreshold = choiceCo and choiceCo.attributeThreshold

	if string.nilorempty(attrThreshold) then
		return
	end

	local attrThresholdList = GameUtil.splitString2(attrThreshold, true)

	for _, thresholdInfo in ipairs(attrThresholdList) do
		local attrId = thresholdInfo[1]
		local thresholdValue = thresholdInfo[2]
		local curAttrValue = Rouge2_Model.instance:getAttrValue(attrId)

		if curAttrValue < thresholdValue then
			return
		end
	end

	return true
end

return Rouge2_MapAttrCheckHelper
