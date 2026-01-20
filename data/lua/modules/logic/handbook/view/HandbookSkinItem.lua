-- chunkname: @modules/logic/handbook/view/HandbookSkinItem.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinItem", package.seeall)

local HandbookSkinItem = class("HandbookSkinItem", LuaCompBase)
local iconBgDefaultSize = {
	376,
	780
}
local spineDefaultSize = {
	500,
	780
}
local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection
local SLFramework_UGUI_GuiHelper = SLFramework.UGUI.GuiHelper
local spineGray = 0.63

function HandbookSkinItem:init(go)
	self.viewGO = go
	self._goUniqueSkin = gohelper.findChild(self.viewGO, "#go_UniqueSkin")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "#simage_icon")
	self._uniqueImageicon = gohelper.findChildImage(self.viewGO, "#simage_icon")
	self._goUniqueImageicon2 = gohelper.findChild(self.viewGO, "#simage_icon2")
	self._roleImage = gohelper.findChildSingleImage(self.viewGO, "root/#image")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root")
	self._btnframeclick = gohelper.findChildButtonWithAudio(self.viewGO, "image_Frame")
	self._uiEffectComp = ZProj_UIEffectsCollection.Get(self.viewGO)
	self._roleImageGraphic = gohelper.findChildImage(self.viewGO, "root/#image")
	self._roleImageFrame = gohelper.findChildImage(self.viewGO, "image_Frame")
	self._goimageL2DRole = gohelper.findChildImage(self.viewGO, "image_L2DRole")

	self:_addEvents()
end

function HandbookSkinItem:setData(suitId)
	self._suitId = suitId
end

function HandbookSkinItem:refreshItem(skinId)
	self._skinId = skinId
	self.skinCfg = SkinConfig.instance:getSkinCo(skinId)
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._suitId)

	local spineParams = self._skinSuitCfg.spineParams

	if string.nilorempty(spineParams) then
		-- block empty
	end

	local spineParamsList = string.split(spineParams, "#")
	local curSkinSpineParam

	if spineParamsList then
		for _, spineParamStr in ipairs(spineParamsList) do
			local spineParam = string.split(spineParamStr, "|")
			local spineSkinId = tonumber(spineParam[1])

			if spineSkinId == skinId then
				curSkinSpineParam = spineParam
			end
		end
	end

	local isUniqueSkin = curSkinSpineParam ~= nil

	if isUniqueSkin then
		gohelper.setActive(self._goUniqueSkinsImage, false)
		gohelper.setActive(self._goUniqueImageicon2, false)
		gohelper.setActive(self._roleImage.gameObject, false)
		gohelper.setActive(self._goimageL2DRole, false)

		local spinePrefabPath = curSkinSpineParam[2]
		local pos = #curSkinSpineParam > 2 and string.splitToNumber(curSkinSpineParam[3], ",") or {
			0,
			0
		}
		local uniScale = #curSkinSpineParam > 3 and tonumber(curSkinSpineParam[4]) or 1

		if self._skinSpine then
			self._skinSpine:setResPath(spinePrefabPath, self._onSkinSpineLoaded, self, true)
		else
			gohelper.setActive(self._goUniqueSkinsImage, true)

			self._skinSpineGO = self._skinSpineGO or gohelper.create2d(self._goUniqueSkinsImage, "uniqueSkinSpine")

			local spineRootRect = self._skinSpineGO.transform

			recthelper.setWidth(spineRootRect, spineDefaultSize[1])
			transformhelper.setLocalPos(spineRootRect, pos[1], pos[2], 0)
			transformhelper.setLocalScale(spineRootRect, uniScale, uniScale, uniScale)

			self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)

			self._skinSpine:setResPath(spinePrefabPath, self._onSkinSpineLoaded, self, true)
		end
	else
		gohelper.setActive(self._goUniqueSkinsImage, false)
		gohelper.setActive(self._goUniqueImageicon2, false)
		self._roleImage:LoadImage(ResUrl.getHeadIconImg(skinId), self._onLoadRoleImageDone, self)

		self._width = self._roleImage.transform.parent.sizeDelta.x
	end

	local has = HeroModel.instance:checkHasSkin(skinId)

	if self._lastHasSkin ~= has then
		self._lastHasSkin = has

		if has then
			self._uiEffectComp:SetGray(false)
		else
			self._uiEffectComp:SetGray(true)
		end

		SLFramework_UGUI_GuiHelper.SetColor(self._roleImageGraphic, has and "#FFFFFF" or "#DCDCDC")

		local isFrameAsIcon = self._btnframeclick ~= nil

		if isFrameAsIcon then
			SLFramework_UGUI_GuiHelper.SetColor(self._roleImageFrame, has and "#FFFFFF" or "#9F9F9F")
		end
	end
end

function HandbookSkinItem:_onLoadRoleImageDone()
	ZProj.UGUIHelper.SetImageSize(self._roleImage.gameObject)
end

function HandbookSkinItem:resetRes()
	if self._roleImage then
		self._roleImage:UnLoadImage()
	end
end

function HandbookSkinItem:_onSkinSpineLoaded()
	local spineTr = self._skinSpine:getSpineTr()
	local rootTrans = spineTr.parent

	recthelper.setWidth(spineTr, recthelper.getWidth(rootTrans))
	recthelper.setHeight(spineTr, recthelper.getHeight(rootTrans))
	self:setSpineRaycastTarget(self._raycastTarget)
end

function HandbookSkinItem:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true and true or false

	if self._skinSpine then
		local spineGraphic = self._skinSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end

		local has = HeroModel.instance:checkHasSkin(self._skinId)

		if not has then
			local mat = spineGraphic.runtimeMaterial

			mat:SetFloat(ShaderPropertyId.LumFactor, spineGray)
		end
	end
end

function HandbookSkinItem:refreshTitle()
	return
end

function HandbookSkinItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)

	if self._btnframeclick then
		self._btnframeclick:AddClickListener(self._btnclickOnClick, self)
	end
end

function HandbookSkinItem:removeEventListeners()
	self._btnclick:RemoveClickListener()

	if self._btnframeclick then
		self._btnframeclick:RemoveClickListener()
	end
end

function HandbookSkinItem:_btnclickOnClick()
	local heroId = self.skinCfg.characterId
	local skinId = self.skinCfg.id
	local skinViewParams = {
		handbook = true,
		storyMode = true,
		heroId = heroId,
		skin = skinId,
		skinSuitId = self._suitId
	}

	CharacterController.instance:openCharacterSkinView(skinViewParams)
end

function HandbookSkinItem:_addEvents()
	return
end

function HandbookSkinItem:_removeEvents()
	return
end

function HandbookSkinItem:onDestroy()
	self:resetRes()
	self:_removeEvents()
	self:removeEventListeners()
end

return HandbookSkinItem
