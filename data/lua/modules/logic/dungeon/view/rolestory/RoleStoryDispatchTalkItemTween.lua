-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchTalkItemTween.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItemTween", package.seeall)

local RoleStoryDispatchTalkItemTween = class("RoleStoryDispatchTalkItemTween", UserDataDispose)

function RoleStoryDispatchTalkItemTween:_playTween_overseas()
	self.text:GetPreferredValues()

	self._lastBottomLeft = 0
	self._lineSpace = 0
	self.transform = self.text.transform
	self.gameObject = self.text.gameObject
	self.canvasGroup = self.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")

	local height = UnityEngine.Screen.height

	self._conMat = self.text.fontMaterial

	self._conMat:EnableKeyword("_GRADUAL_ON")
	self._conMat:SetFloat(self._LineMinYId, height)
	self._conMat:SetFloat(self._LineMaxYId, height)

	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self.transform)

	transformhelper.setLocalPos(self.transform, self._contentX, self._contentY, 1)

	self._fontNormalMat = self.text.fontSharedMaterial
	self._hasUnderline = string.find(self.content, "<u>") and string.find(self.content, "</u>")
	self._lineSpacing = self.text.lineSpacing

	TaskDispatcher.cancelTask(self._delayShow, self)
end

function RoleStoryDispatchTalkItemTween:_initText_overseas()
	self._lastBottomLeft = 0
	self._lineSpace = 0
	self._subMeshs = {}

	local subMeshs = self.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	local textInfo = self.text:GetTextInfo(self.content)
	local totalVisibleCharacterCount = 0
	local uiCamera = CameraMgr.instance:getUICamera()
	local contentTransform = self.transform

	self.textInfo = textInfo
	self.lineInfoList = {}

	for i = 1, textInfo.lineCount do
		local lineInfo = textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		local characterInfo = textInfo.characterInfo
		local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
		local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
		local firstBL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.bottomLeft))
		local firstTL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.topLeft))
		local minbly = firstBL.y
		local maxtly = firstTL.y

		for index = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
			local char = characterInfo[index]
			local bl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.bottomLeft))

			if minbly > bl.y then
				minbly = bl.y
			end

			local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.topLeft))

			if maxtly < tl.y then
				maxtly = tl.y
			end
		end

		firstBL.y = minbly
		firstTL.y = maxtly

		local lastBR = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(lastChar.bottomRight))

		table.insert(self.lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount,
			firstBL,
			firstTL,
			lastBR
		})
	end

	self.characterCount = totalVisibleCharacterCount
	self.delayTime = self:getDelayTime(totalVisibleCharacterCount)
	self._curLine = nil

	GameUtil.onDestroyViewMember_TweenId(self, "tweenId")
end

function RoleStoryDispatchTalkItemTween:_frameCallback_overseas(value)
	local screenWidth = UnityEngine.Screen.width

	for i, v in ipairs(self.lineInfoList) do
		local lineInfo = v[1]
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount and startCount ~= endCount then
			local firstBL = v[4]
			local firstTL = v[5]
			local lastBR = v[6]

			if self._curLine ~= i then
				self._curLine = i

				local maxBL_y = firstBL.y
				local maxTL = firstTL

				for _, mesh in pairs(self._subMeshs) do
					if mesh.sharedMaterial then
						mesh.sharedMaterial = self._fontNormalMat
					end
				end

				if i == 1 then
					if self._hasUnderline then
						self._conMat:SetFloat(self._LineMinYId, maxBL_y - 4)
					else
						self._conMat:SetFloat(self._LineMinYId, maxBL_y)
					end

					self._conMat:SetFloat(self._LineMaxYId, maxTL.y)
				else
					self._lineSpace = self._lastBottomLeft - maxTL.y > 0 and self._lastBottomLeft - maxTL.y or self._lineSpace

					self._conMat:SetFloat(self._LineMinYId, maxBL_y)
					self._conMat:SetFloat(self._LineMaxYId, maxTL.y + self._lineSpace)
				end

				self._lastBottomLeft = maxBL_y

				local go = self.gameObject

				gohelper.setActive(go, false)
				gohelper.setActive(go, true)
			end

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(firstBL.x - 10, lastBR.x + 10, rate)
			local posZ = 1 - screenPosX / screenWidth
			local x, y, _ = transformhelper.getLocalPos(self.transform)

			transformhelper.setLocalPos(self.transform, x, y, posZ)
		end
	end
end

function RoleStoryDispatchTalkItemTween:_onTextFinished_overseas()
	self:killTween()
	self:_disable_GRADUAL_ON()

	local x, y, z = transformhelper.getLocalPos(self.transform)

	transformhelper.setLocalPos(self.transform, x, y, 0)
	self:_doCallback()
end

function RoleStoryDispatchTalkItemTween:_disable_GRADUAL_ON()
	for _, mesh in pairs(self._subMeshs or {}) do
		local material = mesh.sharedMaterial

		if not gohelper.isNil(material) then
			material:DisableKeyword("_GRADUAL_ON")
			material:SetFloat(self._LineMinYId, 0)
			material:SetFloat(self._LineMaxYId, 0)
		end
	end

	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._conMat:SetFloat(self._LineMinYId, 0)
	self._conMat:SetFloat(self._LineMaxYId, 0)
end

function RoleStoryDispatchTalkItemTween:ctor()
	self:__onInit()
end

function RoleStoryDispatchTalkItemTween:playTween(text, content, callback, callbackObj, scrollContent)
	self:killTween()

	self.callback = callback
	self.callbackObj = callbackObj
	self.text = text
	self.content = content
	self.scrollContent = scrollContent

	self:_playTween_overseas()
	TaskDispatcher.runDelay(self._delayShow, self, 0.05)
end

function RoleStoryDispatchTalkItemTween:_delayShow()
	self:_initText_overseas()

	self.canvasGroup.alpha = 1
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(1, self.characterCount, self.delayTime, self.frameCallback, self.onTextFinished, self, nil, EaseType.Linear)

	self:moveContent()
end

function RoleStoryDispatchTalkItemTween:moveContent()
	local contentTransform = self.scrollContent.transform
	local scrollHeight = recthelper.getHeight(contentTransform.parent)
	local contentHeight = recthelper.getHeight(contentTransform)
	local maxPos = math.max(contentHeight - scrollHeight, 0)
	local txtPos = recthelper.getAnchorY(self.transform.parent)
	local txtHeight = recthelper.getHeight(self.transform.parent)
	local txtPosY = txtPos + txtHeight
	local caleMovePosY = math.max(maxPos, txtPosY - scrollHeight)

	self.moveId = ZProj.TweenHelper.DOAnchorPosY(contentTransform, caleMovePosY, self.delayTime * 0.8, nil, nil, nil, EaseType.Linear)
end

function RoleStoryDispatchTalkItemTween:_doCallback()
	local callback = self.callback
	local callbackObj = self.callbackObj

	self.callback = nil
	self.callbackObj = nil

	if callback then
		callback(callbackObj)
	end
end

function RoleStoryDispatchTalkItemTween:frameCallback(value)
	do return self:_frameCallback_overseas(value) end

	local screenWidth = UnityEngine.Screen.width
	local uiCamera = CameraMgr.instance:getUICamera()

	for i, v in ipairs(self.lineInfoList) do
		local lineInfo = v[1]
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount then
			local characterInfo = self.textInfo.characterInfo
			local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
			local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
			local firstBL = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(firstChar.bottomLeft))
			local maxBL = firstBL
			local minbly = firstBL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(char.bottomLeft))

				if minbly > tl.y then
					minbly = tl.y
				end
			end

			maxBL.y = minbly

			local firstTL = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(firstChar.topLeft))
			local maxTL = firstTL
			local maxtly = firstTL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(char.topLeft))

				if maxtly < tl.y then
					maxtly = tl.y
				end
			end

			maxTL.y = maxtly

			local lastBR = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(lastChar.bottomRight))

			if i == 1 then
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + 10)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y + 10)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			local go = self.gameObject

			gohelper.setActive(go, false)
			gohelper.setActive(go, true)

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(maxBL.x - 10, lastBR.x + 10, rate)
			local posZ = 1 - screenPosX / screenWidth

			transformhelper.setLocalPos(self.transform, self._contentX, self._contentY, posZ)
		end
	end
end

function RoleStoryDispatchTalkItemTween:onTextFinished()
	do return self:_onTextFinished_overseas() end

	self:killTween()

	local x, y, z = transformhelper.getLocalPos(self.transform)

	transformhelper.setLocalPos(self.transform, x, y, 0)
	self._conMat:DisableKeyword("_GRADUAL_ON")

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	self:_doCallback()
end

function RoleStoryDispatchTalkItemTween:initText()
	self.transform = self.text.transform
	self.gameObject = self.text.gameObject
	self.canvasGroup = self.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._subMeshs = {}
	self._conMat = self.text.fontMaterial

	self._conMat:EnableKeyword("_GRADUAL_ON")
	self._conMat:DisableKeyword("_DISSOLVE_ON")

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")
	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self.transform)

	local subMeshs = self.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	self.textInfo = self.text:GetTextInfo(self.content)
	self.lineInfoList = {}

	local totalVisibleCharacterCount = 0

	for i = 1, self.textInfo.lineCount do
		local lineInfo = self.textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		table.insert(self.lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount
		})
	end

	self.characterCount = totalVisibleCharacterCount
	self.delayTime = self:getDelayTime(totalVisibleCharacterCount)
end

function RoleStoryDispatchTalkItemTween:getDelayTime(characterCount)
	local speed = 4
	local time = 0.08 * characterCount

	time = time / speed

	return time
end

function RoleStoryDispatchTalkItemTween:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.moveId then
		ZProj.TweenHelper.KillById(self.moveId)

		self.moveId = nil
	end

	TaskDispatcher.cancelTask(self._delayShow, self)
end

function RoleStoryDispatchTalkItemTween:destroy()
	self:killTween()
	self:__onDispose()
end

return RoleStoryDispatchTalkItemTween
