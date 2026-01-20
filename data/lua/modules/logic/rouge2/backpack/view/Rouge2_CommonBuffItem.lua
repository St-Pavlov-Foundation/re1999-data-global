-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonBuffItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonBuffItem", package.seeall)

local Rouge2_CommonBuffItem = class("Rouge2_CommonBuffItem", LuaCompBase)

function Rouge2_CommonBuffItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CommonBuffItem)
end

function Rouge2_CommonBuffItem:init(go)
	self.go = go
	self._imageBg = gohelper.findChildImage(self.go, "root/BG")
	self._imageRare = gohelper.findChildImage(self.go, "root/Info/#image_Rare")
	self._imageNameBg = gohelper.findChildImage(self.go, "root/Info/image_namebg")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "root/Info/#image_Icon")
	self._txtName = gohelper.findChildText(self.go, "root/Info/#txt_Name")
	self._txtRareName = gohelper.findChildText(self.go, "root/Info/#txt_RareName")
	self._goContainer = gohelper.findChild(self.go, "root/#go_Container")
	self._txtDesc = gohelper.findChildText(self.go, "root/#go_Container/#txt_Desc")
	self._goSelect = gohelper.findChild(self.go, "root/#go_Select")
	self._goReddot = gohelper.findChild(self.go, "root/Info/#go_Reddot")
	self._goTag = gohelper.findChild(self.go, "root/#go_Tag")
	self._imageTagBg = gohelper.findChildImage(self.go, "root/#go_Tag")
	self._txtTag = gohelper.findChildText(self.go, "root/#go_Tag/#txt_Tag")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)

	gohelper.setActive(self._goReddot, false)
	gohelper.setActive(self._goSelect, false)
	self:initRareEffectTab()
end

function Rouge2_CommonBuffItem:addEventListeners()
	return
end

function Rouge2_CommonBuffItem:removeEventListeners()
	return
end

function Rouge2_CommonBuffItem:getReddotGo()
	return self._goReddot
end

function Rouge2_CommonBuffItem:onUpdateMO(dataType, id)
	self._dataType = dataType
	self._id = id
	self._buffCo, self._buffMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, id)
	self._buffId = self._buffCo and self._buffCo.id

	self:refreshUI()
end

function Rouge2_CommonBuffItem:refreshUI()
	self:showRareEffect()

	self._txtName.text = self._buffCo and self._buffCo.name

	Rouge2_IconHelper.setBuffIcon(self._buffId, self._simageIcon)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageRare)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageBg, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageNameBg, Rouge2_Enum.ItemRareIconType.NameBg)
	Rouge2_IconHelper.setBuffRareIcon(self._buffId, self._imageTagBg, Rouge2_Enum.ItemRareIconType.TagBg)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._id, self._txtDesc)
	Rouge2_ItemDescHelper.setBuffTag(self._dataType, self._id, self._goTag, self._txtTag.gameObject)

	local rareCo = Rouge2_CollectionConfig.instance:getRareConfig(self._buffCo.rare)
	local rareName = rareCo and rareCo.name
	local rareColor = rareCo and rareCo.buffColor

	self._txtRareName.text = string.format("<#%s>%s</color>", rareColor, rareName)
end

function Rouge2_CommonBuffItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	local animName = isSelect and "light" or "normal"

	self:playAnim(animName)
end

function Rouge2_CommonBuffItem:playAnim(animName)
	if not self.go.activeInHierarchy then
		return
	end

	self._animator:Play(animName, 0, 0)
end

function Rouge2_CommonBuffItem:initRareEffectTab()
	self._rareEffectTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self.go, "root/Info/#Rare")
	local tranParent = goParent.transform
	local effectNum = tranParent.childCount

	for i = 1, effectNum do
		local goeffect = tranParent:GetChild(i - 1).gameObject
		local effectName = goeffect.name

		self._rareEffectTab[effectName] = goeffect
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_CommonBuffItem:showRareEffect()
	local rare = self._buffCo and self._buffCo.rare
	local rareName = string.format("rare%s", rare)

	for effectName, goRare in pairs(self._rareEffectTab) do
		gohelper.setActive(goRare, effectName == rareName)
	end
end

function Rouge2_CommonBuffItem:onDestroy()
	self._simageIcon:UnLoadImage()
end

return Rouge2_CommonBuffItem
