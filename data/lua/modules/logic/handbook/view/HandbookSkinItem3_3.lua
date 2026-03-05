-- chunkname: @modules/logic/handbook/view/HandbookSkinItem3_3.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinItem3_3", package.seeall)

local HandbookSkinItem3_3 = class("HandbookSkinItem3_3", LuaCompBase)

function HandbookSkinItem3_3:init(go)
	self.viewGO = go
	self._roleImage = gohelper.findChildSingleImage(self.viewGO, "item/unlock/#simage_card")
	self._roleImageLock = gohelper.findChildSingleImage(self.viewGO, "item/lock/#simage_card")
	self._gobtnclick = gohelper.findChild(self.viewGO, "item/unlock/#simage_card")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "item/unlock/#simage_card")
	self._btnlockclick = gohelper.findChildButtonWithAudio(self.viewGO, "item/lock/#simage_card")
	self._btnEmpty = gohelper.findChildButtonWithAudio(self.viewGO, "item/empty")
	self._goEmpty = gohelper.findChild(self.viewGO, "item/empty")
	self._goUnlock = gohelper.findChild(self.viewGO, "item/unlock")
	self._goLock = gohelper.findChild(self.viewGO, "item/lock")
	self._goDestivalItemSelected = gohelper.findChild(self.viewGO, "LineItem/selected")
	self._goDestivalItemUnSelect = gohelper.findChild(self.viewGO, "LineItem/unselect")
	self._goLineItemImgDesc = gohelper.findChild(self.viewGO, "LineItem/unselect/image_dec2")
	self._goLineItemImgDesc2 = gohelper.findChild(self.viewGO, "LineItem/unselect/image_dec4")
	self._goDesTextUnSelect = gohelper.findChild(self._goDestivalItemUnSelect, "#txt_Descr")
	self._goDateTextUnSelect = gohelper.findChild(self._goDestivalItemUnSelect, "#txt_Date")
	self._desTextUnSelect = gohelper.findChildText(self._goDestivalItemUnSelect, "#txt_Descr")
	self._dateTextUnSelect = gohelper.findChildText(self._goDestivalItemUnSelect, "#txt_Date")
	self._goCardSelect = gohelper.findChild(self.viewGO, "item/unlock/#go_select")
	self._goItem = gohelper.findChild(self.viewGO, "item")
	self._itemAnimator = self._goItem:GetComponent(gohelper.Type_Animator)
end

function HandbookSkinItem3_3:setData(idx, suitId)
	self._cardIdx = idx
	self._suitId = suitId
end

function HandbookSkinItem3_3:refreshItem(skinId)
	self._skinId = skinId

	if self._skinId == 0 then
		self:_refreshEmptySkin()

		return
	end

	self.skinCfg = SkinConfig.instance:getSkinCo(skinId)
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._suitId)

	local spineParams = self._skinSuitCfg.spineParams

	if string.nilorempty(spineParams) then
		-- block empty
	end

	local spineParamsList = string.split(spineParams, "#")

	gohelper.setActive(self._goUniqueSkinsImage, false)
	self._roleImage:LoadImage(ResUrl.getSkinHandbookFestivalSkinImage(skinId), self._onLoadRoleImageDone, self)
	self._roleImageLock:LoadImage(ResUrl.getSkinHandbookFestivalSkinImage(skinId), self._onLoadRoleImageDone, self)

	self._width = self._roleImage.transform.parent.sizeDelta.x

	local has = HeroModel.instance:checkHasSkin(skinId)

	gohelper.setActive(self._roleImage.gameObject, has)
	gohelper.setActive(self._goLock, not has)
	gohelper.setActive(self._goEmpty, false)
end

function HandbookSkinItem3_3:refreshSelectedState(selected)
	self._itemAnimator:Play(selected and UIAnimationName.Select or UIAnimationName.Idle, 0, 0)
	gohelper.setActive(self._goDestivalItemSelected, selected)
	gohelper.setActive(self._goCardSelect, selected)
end

function HandbookSkinItem3_3:_refreshEmptySkin()
	gohelper.setActive(self._goEmpty, true)
	gohelper.setActive(self._roleImage.gameObject, false)
	gohelper.setActive(self._goLock, false)
end

function HandbookSkinItem3_3:_onLoadRoleImageDone()
	ZProj.UGUIHelper.SetImageSize(self._roleImage.gameObject)
end

function HandbookSkinItem3_3:resetRes()
	if self._roleImage then
		self._roleImage:UnLoadImage()
	end
end

function HandbookSkinItem3_3:refreshDestivalData(destivalDataStr)
	local destivalDataParams = string.split(destivalDataStr, ",")

	self._desTextUnSelect.text = destivalDataStr ~= "0" and luaLang(destivalDataParams[1]) or ""
	self._dateTextUnSelect.text = destivalDataStr ~= "0" and destivalDataParams[2] or ""

	gohelper.setActive(self._goLineItemImgDesc, self._dateTextUnSelect.text ~= "")
end

function HandbookSkinItem3_3:addEventListeners()
	self._btnClick:AddClickListener(self._btnclickOnClick, self)

	if self._btnlockclick then
		self._btnlockclick:AddClickListener(self._btnclickOnClick, self)
	end

	self._btnEmpty:AddClickListener(self._btnclickOnClick, self)
end

function HandbookSkinItem3_3:removeEventListeners()
	self._btnClick:RemoveClickListener()

	if self._btnlockclick then
		self._btnlockclick:RemoveClickListener()
	end

	self._btnEmpty:RemoveClickListener()
end

function HandbookSkinItem3_3:_btnclickOnClick()
	HandbookController.instance:dispatchEvent(HandbookEvent.OnClickFestivalSkinCard, self._cardIdx, self._skinId)
end

function HandbookSkinItem3_3:getSkinId()
	return self._skinId
end

function HandbookSkinItem3_3:onDestroy()
	self:resetRes()
	self:removeEventListeners()
end

return HandbookSkinItem3_3
