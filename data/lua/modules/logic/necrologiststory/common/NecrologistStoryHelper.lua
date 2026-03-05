-- chunkname: @modules/logic/necrologiststory/common/NecrologistStoryHelper.lua

module("modules.logic.necrologiststory.common.NecrologistStoryHelper", package.seeall)

local NecrologistStoryHelper = class("NecrologistStoryHelper")

function NecrologistStoryHelper.addHyperLinkClick(textComp, clickCallback, clickCallbackObj)
	if gohelper.isNil(textComp) then
		logError("textComp is nil, please check !!!")

		return
	end

	local hyperLinkClick = gohelper.onceAddComponent(textComp, typeof(ZProj.TMPHyperLinkClick))

	hyperLinkClick:SetClickListener(clickCallback or NecrologistStoryHelper.defaultClick, clickCallbackObj)
end

function NecrologistStoryHelper.defaultClick(linkId, clickPosition)
	NecrologistStoryController.instance:openTipView(linkId, clickPosition)
end

function NecrologistStoryHelper.getDesc(storyId, bracketColor)
	local config = NecrologistStoryConfig.instance:getStoryConfig(storyId)

	return NecrologistStoryHelper.getDescByConfig(config, bracketColor)
end

function NecrologistStoryHelper.getDescByConfig(storyConfig, bracketColor)
	local desc = storyConfig.desc

	return NecrologistStoryHelper.buildDesc(desc, bracketColor)
end

function NecrologistStoryHelper.buildDesc(desc, bracketColor)
	local hasLink = false

	desc = NecrologistStoryHelper.addColor(desc, bracketColor)
	desc, hasLink = NecrologistStoryHelper.addLink(desc)

	return desc, hasLink
end

function NecrologistStoryHelper.addLink(desc)
	local count = 0
	local hasLink = false

	desc, count = string.gsub(desc, "%[(.-)%]", NecrologistStoryHelper._replaceDescTagFunc1)
	hasLink = count ~= 0
	desc, count = string.gsub(desc, "【(.-)】", NecrologistStoryHelper._replaceDescTagFunc2)

	if count ~= 0 then
		hasLink = true
	end

	return desc, hasLink
end

function NecrologistStoryHelper._replaceDescTagFunc1(name)
	local co = NecrologistStoryConfig.instance:getIntroduceCoByName(name)

	name = NecrologistStoryHelper.removeRichTag(name)

	if not co then
		return name
	end

	if not co.notAddLink or co.notAddLink == 0 then
		return string.format("<u><link=%s>%s</link></u>", co.id, name)
	end

	return name
end

function NecrologistStoryHelper._replaceDescTagFunc2(name)
	local co = NecrologistStoryConfig.instance:getIntroduceCoByName(name)

	name = NecrologistStoryHelper.removeRichTag(name)

	if not co then
		return name
	end

	if not co.notAddLink or co.notAddLink == 0 then
		return string.format("<u><link=%s>%s</link></u>", co.id, name)
	end

	return name
end

function NecrologistStoryHelper.removeRichTag(name)
	return string.gsub(name, "<.->", "")
end

function NecrologistStoryHelper.loadSituationFunc(situation)
	local condition = string.format("return %s", situation)
	local func, err = loadstring(condition)

	if not func then
		logError(string.format("条件表达式错误 表达式:%s error:%s", situation, err))
	end

	return func
end

function NecrologistStoryHelper.addColor(desc, bracketColor)
	desc = NecrologistStoryHelper.addBracketColor(desc, bracketColor)

	return desc
end

function NecrologistStoryHelper.addBracketColor(desc, bracketColor)
	if string.nilorempty(bracketColor) then
		bracketColor = "#AE5D30"
	end

	local bracketColorFormat = NecrologistStoryHelper.getColorFormat(bracketColor, "%1")

	desc = string.gsub(desc, "%[.-%]", bracketColorFormat)
	desc = string.gsub(desc, "【.-】", bracketColorFormat)

	return desc
end

function NecrologistStoryHelper.getColorFormat(color, text)
	return string.format("<color=%s>%s</color>", color, text)
end

function NecrologistStoryHelper.getTimeFormat(time)
	local hour = math.floor(time)
	local minute = math.floor((time - hour) * 60)
	local period = hour >= 12 and "PM" or "AM"
	local displayHour = hour % 12

	if displayHour == 0 then
		displayHour = 12
	end

	return displayHour, minute, period
end

function NecrologistStoryHelper.getTimeFormat2(time)
	local hour = math.floor(time)
	local minute = math.floor((time - hour) * 60)
	local displayHour = hour % 24

	return displayHour, minute
end

NecrologistStoryHelper.DialogNameTag = "{roleName}"

function NecrologistStoryHelper.getDialogName(storyConfig)
	local name = storyConfig.name

	if string.match(name, NecrologistStoryHelper.DialogNameTag) then
		local storyGroupConfig = NecrologistStoryConfig.instance:getPlotGroupCo(storyConfig.storygroup)

		return true, string.gsub(name, NecrologistStoryHelper.DialogNameTag, storyGroupConfig.roleName)
	end

	return false, name
end

function NecrologistStoryHelper.checkDragDirection(startPos, endPos, checkDir)
	local dragDeltaX = endPos.x - startPos.x
	local dragDeltaY = endPos.y - startPos.y

	if checkDir == NecrologistStoryEnum.DirType.Left then
		return dragDeltaX < 0
	elseif checkDir == NecrologistStoryEnum.DirType.Right then
		return dragDeltaX > 0
	elseif checkDir == NecrologistStoryEnum.DirType.Top then
		return dragDeltaY > 0
	elseif checkDir == NecrologistStoryEnum.DirType.Bottom then
		return dragDeltaY < 0
	end

	return true
end

function NecrologistStoryHelper.getPlotRoleStoryId(plotId)
	local config = NecrologistStoryConfig.instance:getStoryConfig(plotId)
	local storyGroupConfig = NecrologistStoryConfig.instance:getPlotGroupCo(config.storygroup)

	return storyGroupConfig.storyId
end

function NecrologistStoryHelper.calculateLinksRectData(tmpText)
	local list = {}
	local textTransform = tmpText.transform
	local linkInfoList = tmpText.textInfo.linkInfo
	local characterInfoList = tmpText.textInfo.characterInfo
	local camera = CameraMgr.instance:getUICamera()
	local bl, tr
	local iter = linkInfoList:GetEnumerator()

	while iter:MoveNext() do
		local linkInfo = iter.Current
		local answerIndex = tonumber(linkInfo:GetLinkID())
		local firstCharInfo = characterInfoList[linkInfo.linkTextfirstCharacterIndex]

		bl = textTransform:TransformPoint(Vector3.New(firstCharInfo.bottomLeft.x, firstCharInfo.descender, 0))

		if linkInfo.linkTextLength == 1 then
			tr = textTransform:TransformPoint(Vector3.New(firstCharInfo.topRight.x, firstCharInfo.ascender, 0))

			local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

			table.insert(list, {
				centerPos,
				width,
				height,
				answerIndex
			})
		elseif linkInfo.linkTextLength > 1 then
			local lastCharInfo = characterInfoList[linkInfo.linkTextfirstCharacterIndex + linkInfo.linkTextLength - 1]

			if firstCharInfo.lineNumber == lastCharInfo.lineNumber then
				tr = textTransform:TransformPoint(Vector3.New(lastCharInfo.topRight.x, lastCharInfo.ascender, 0))

				local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

				table.insert(list, {
					centerPos,
					width,
					height,
					answerIndex
				})
			else
				tr = textTransform:TransformPoint(Vector3.New(firstCharInfo.topRight.x, firstCharInfo.ascender, 0))

				local startLineNumber = firstCharInfo.lineNumber

				for i = 1, linkInfo.linkTextLength - 1 do
					local characterIndex = linkInfo.linkTextfirstCharacterIndex + i
					local tmpCharInfo = characterInfoList[characterIndex]
					local currentLineNumber = tmpCharInfo.lineNumber

					if currentLineNumber == startLineNumber then
						tr = textTransform:TransformPoint(Vector3.New(tmpCharInfo.topRight.x, tmpCharInfo.ascender, 0))
					else
						local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

						table.insert(list, {
							centerPos,
							width,
							height,
							answerIndex
						})

						startLineNumber = currentLineNumber
						bl = textTransform:TransformPoint(Vector3.New(tmpCharInfo.bottomLeft.x, tmpCharInfo.descender, 0))
						tr = textTransform:TransformPoint(Vector3.New(tmpCharInfo.topRight.x, tmpCharInfo.ascender, 0))
					end
				end

				local centerPos, width, height = NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)

				table.insert(list, {
					centerPos,
					width,
					height,
					answerIndex
				})
			end
		end
	end

	return list
end

function NecrologistStoryHelper.getCenterPosAndSize(bl, tr, tmpText, camera)
	local blPos = recthelper.worldPosToAnchorPos(bl, tmpText.transform, camera, camera)
	local trPos = recthelper.worldPosToAnchorPos(tr, tmpText.transform, camera, camera)
	local centerPos = (blPos + trPos) * 0.5
	local width = trPos.x - blPos.x
	local height = trPos.y - blPos.y

	return centerPos, width, height
end

return NecrologistStoryHelper
