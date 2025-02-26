module("modules.logic.guide.model.GuideViewParam", package.seeall)

slot0 = pureTable("GuideViewParam")

function slot0.ctor(slot0)
	slot0.guideId = nil
	slot0.stepId = nil
	slot0.enableHoleClick = true
	slot0.uiOffset = nil
	slot0.goPath = nil
	slot0.touchGOPath = nil
	slot0.enableClick = true
	slot0.enableDrag = false
	slot0.enablePress = false
	slot0.enableSpaceBtn = false
	slot0.tipsPos = nil
	slot0.tipsHead = nil
	slot0.tipsTalker = nil
	slot0.tipsContent = nil
	slot0.hasTips = false
	slot0.hasDialogue = false
	slot0.storyContent = nil
	slot0.hasStory = false
end

function slot0.setStep(slot0, slot1, slot2)
	slot0.guideId = slot1
	slot0.stepId = slot2
	slot3 = GuideConfig.instance:getStepCO(slot1, slot2)

	slot0:initUiType(slot3.uiInfo)
	slot0:setUiOffset(slot3.uiOffset)
	slot0:setGoPath(GuideModel.instance:getStepGOPath(slot1, slot2))

	slot0.touchGOPath = slot3.touchGOPath
	slot0.tipsPos = string.splitToNumber(slot3.tipsPos, "#")
	slot0.tipsHead = slot3.tipsHead
	slot0.tipsTalker = slot3.tipsTalker
	slot0.tipsContent = slot3.tipsContent
	slot0.tipsDir = slot3.tipsDir

	if not string.nilorempty(slot0.tipsContent) then
		slot0.hasTips = not string.nilorempty(slot3.tipsPos)
	else
		slot0.hasTips = false
		slot0.hasDialogue = false
	end

	slot0.portraitPos = slot3.portraitPos
	slot0.storyContent = slot3.storyContent
	slot0.hasStory = not string.nilorempty(slot0.storyContent)
	slot0.otherMasks = slot0:getOtherMasks(slot3)
	slot0.hasAnyTouchAction = slot0:hasAction(slot3.action, 212)
end

function slot0.getOtherMasks(slot0, slot1)
	if slot1.maskId > 0 then
		if not lua_guide_mask.configDict[slot1.maskId] then
			return
		end

		slot3 = {}

		for slot7 = 1, 4 do
			slot10 = slot2["goPath" .. slot7]

			if not string.nilorempty(slot2["uiInfo" .. slot7]) and not string.nilorempty(slot10) then
				table.insert(slot3, {
					uiInfo = slot0:getUiTypeParam(slot9),
					goPath = slot10,
					uiOffset = string.splitToNumber(slot2["uiOffset" .. slot7], "#")
				})
			end
		end

		return #slot3 > 0 and slot3
	end
end

function slot0.hasAction(slot0, slot1, slot2)
	if string.nilorempty(slot1) == false then
		slot7 = "#"

		for slot7, slot8 in ipairs(GameUtil.splitString2(slot1, true, "|", slot7)) do
			if slot8[1] == slot2 then
				return true
			end
		end
	end

	return false
end

function slot0.setGoPath(slot0, slot1)
	slot0.goPath = slot1
end

function slot0.setUiOffset(slot0, slot1)
	slot0.uiOffset = string.splitToNumber(slot1, "#")
end

function slot0.initUiType(slot0, slot1)
	slot0.uiInfo = slot0:getUiTypeParam(slot1)
	slot0.showMask = slot0.uiInfo.maskAlpha ~= 0
end

function slot0.getUiTypeParam(slot0, slot1)
	slot4, slot5 = nil

	if ({
		uiType = string.splitToNumber(slot1, "#")[1],
		width = 0,
		height = 0
	}).uiType == GuideEnum.uiTypeCircle then
		slot2.width = slot3[2]
		slot2.height = slot3[2]
		slot5 = slot3[3]
		slot4 = slot3[4]
	elseif slot2.uiType == GuideEnum.uiTypeRectangle then
		slot2.width = slot3[2]
		slot2.height = slot3[3]
		slot5 = slot3[4]
		slot4 = slot3[5]
	elseif slot2.uiType == GuideEnum.uiTypeNoHole then
		slot5 = slot3[2] or 0.2
		slot4 = 0
	elseif slot2.uiType == GuideEnum.uiTypeDragCard or slot2.uiType == GuideEnum.uiTypeDragCard2 then
		slot5 = slot3[2]
	elseif slot2.uiType == GuideEnum.uiTypeArrow or slot2.uiType == GuideEnum.uiTypePressArrow then
		slot2.rotation = GuideEnum.ArrowRotation[slot3[2] or 1]
		slot2.width = slot3[3] or 0
		slot2.height = slot3[4] or 0
		slot2.arrowOffsetX = slot3[5] or 0
		slot2.arrowOffsetY = slot3[6] or 0
		slot5 = slot3[7]
		slot4 = slot3[8]
	end

	slot2.maskAlpha = slot5 or 0
	slot2.imgAlpha = slot4 or 0
	slot2.stepId = slot0.stepId
	slot2.guideId = slot0.guideId

	return slot2
end

function slot0.setHole(slot0)
end

function slot0.setTips(slot0)
end

function slot0.setStory(slot0)
end

return slot0
