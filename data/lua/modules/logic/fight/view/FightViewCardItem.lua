-- chunkname: @modules/logic/fight/view/FightViewCardItem.lua

module("modules.logic.fight.view.FightViewCardItem", package.seeall)

local FightViewCardItem = class("FightViewCardItem", LuaCompBase)

FightViewCardItem.TagPosForLvs = nil

function FightViewCardItem:ctor(handCardType)
	self.handCardType = handCardType or FightEnum.CardShowType.Default
end

function FightViewCardItem:init(go)
	self.go = go
	self._canvasGroup = go:GetComponent(gohelper.Type_CanvasGroup)
	self.tr = go.transform
	self._lvGOs = self:getUserDataTb_()
	self._lvImgIcons = self:getUserDataTb_()
	self._lvImgComps = self:getUserDataTb_()
	self._starItemCanvas = self:getUserDataTb_()
	self.skillIconBg = self:getUserDataTb_()
	self.attributeBg = self:getUserDataTb_()
	self.highlightEffect = self:getUserDataTb_()

	for i = 0, 4 do
		local lvGO = gohelper.findChild(go, "lv" .. i)
		local lvIcon = gohelper.findChildSingleImage(lvGO, "imgIcon")
		local lvImgComp = gohelper.findChildImage(lvGO, "imgIcon")

		gohelper.setActive(lvGO, true)

		self._lvGOs[i] = lvGO
		self._lvImgIcons[i] = lvIcon
		self._lvImgComps[i] = lvImgComp

		local obj = gohelper.findChild(lvGO, "image")

		self.attributeBg[i] = obj
		obj = gohelper.findChild(lvGO, "bg")
		self.skillIconBg[i] = obj
		self.highlightEffect[i] = gohelper.findChild(lvGO, "#pc_highlighted")
	end

	if not FightViewCardItem.TagPosForLvs then
		FightViewCardItem.TagPosForLvs = {}

		for i = 0, 4 do
			local x, y = recthelper.getAnchor(gohelper.findChild(go, "tag/pos" .. i).transform)

			FightViewCardItem.TagPosForLvs[i] = {
				x,
				y
			}
		end
	end

	self.goTag = gohelper.findChild(go, "tag")
	self.tagCanvas = gohelper.onceAddComponent(self.goTag, typeof(UnityEngine.CanvasGroup))
	self._tagRootTr = gohelper.findChild(go, "tag/tag").transform
	self._tag = gohelper.findChildSingleImage(go, "tag/tag/tagIcon")
	self.tagTransform = self._tag.transform
	self._txt = gohelper.findChildText(go, "Text")
	self._starGO = gohelper.findChild(go, "star")
	self._starCanvas = gohelper.onceAddComponent(self._starGO, typeof(UnityEngine.CanvasGroup))
	self._innerStartGOs = self:getUserDataTb_()

	for i = 1, FightEnum.MaxSkillCardLv do
		local starObj = gohelper.findChild(go, "star/star" .. i)

		table.insert(self._innerStartGOs, starObj)
		table.insert(self._starItemCanvas, gohelper.onceAddComponent(starObj, typeof(UnityEngine.CanvasGroup)))
	end

	self._layout = gohelper.findChild(self.go, "layout")

	gohelper.setActive(self._layout, true)

	self._predisplay = gohelper.findChild(go, "layout/predisplay")
	self._cardAni = gohelper.onceAddComponent(go, typeof(UnityEngine.Animator))
	self._cardAppearEffectRoot = gohelper.findChild(go, "cardAppearEffectRoot")
	self._cardMask = gohelper.findChild(go, "cardmask")
	self._maskList = self:getUserDataTb_()

	for i = 1, 4 do
		table.insert(self._maskList, gohelper.findChild(self._cardMask, "lv" .. i))
	end

	self._resistanceComp = MonoHelper.addLuaComOnceToGo(self.go, FightViewCardItemResistance, self)
	self._loader = self._loader or FightLoaderComponent.New()
	self._countRoot = gohelper.findChild(self.go, "layout/count")
	self._countText = gohelper.findChildText(self.go, "layout/count/#txt_count")

	gohelper.setActive(self._countRoot, false)

	self._abandon = gohelper.findChild(self.go, "layout/abandon")

	gohelper.setActive(self._abandon, false)

	self.goRouge2Double = gohelper.findChild(self.go, "layout/rouge2_double")

	gohelper.setActive(self.goRouge2Double, false)

	self._blockadeTwo = gohelper.findChild(self.go, "#go_enchant_effect")

	gohelper.setActive(self._blockadeTwo, false)

	self._blockadeOne = gohelper.findChild(self.go, "#go_enchant_uneffect")

	gohelper.setActive(self._blockadeOne, false)

	self._precision = gohelper.findChild(self.go, "AccurateEnchant")

	gohelper.setActive(self._precision, false)

	self._precisionEffect = gohelper.findChild(self.go, "AccurateEnchant/effect")

	gohelper.setActive(self._precisionEffect, false)
	self:initSuperimposeNode()

	self.goTopLayout = gohelper.findChild(go, "topLayout")
	self.showASFD = false
	self.goASFD = gohelper.findChild(go, "topLayout/asfd_icon")

	gohelper.setActive(self.goASFD, false)

	self.txtASFDEnergy = gohelper.findChildText(go, "topLayout/asfd_icon/#txt_Num")
	self.goRouge2Double_HandCard = gohelper.findChild(go, "topLayout/rouge_fumo")

	gohelper.setActive(self.goRouge2Double_HandCard, false)

	self.showRouge2Music = true
	self.goRouge2Music = gohelper.findChild(go, "topLayout/rouge_skill")

	gohelper.setActive(self.goRouge2Music, false)

	self.imageRouge2Music = gohelper.findChildImage(go, "topLayout/rouge_skill/#image_icon")
	self.rouge2FuMo = gohelper.findChild(go, "topLayout/rouge_fumo")

	gohelper.setActive(self.rouge2FuMo, false)

	self.goASFDSkill = gohelper.findChild(go, "asfd")
	self.asfdSkillSimage = gohelper.findChildSingleImage(go, "asfd/imgIcon")
	self.asfdNumTxt = gohelper.findChildText(go, "asfd/#txt_Num")
	self.goPreDelete = gohelper.findChild(go, "go_predelete")
	self.goPreDeleteNormal = gohelper.findChild(go, "go_predelete/normal")
	self.goPreDeleteUnique = gohelper.findChild(go, "go_predelete/ultimate")
	self.goPreDeleteLeft = gohelper.findChild(go, "go_predelete/Left")
	self.goPreDeleteRight = gohelper.findChild(go, "go_predelete/Right")
	self.goPreDeleteBoth = gohelper.findChild(go, "go_predelete/Both")

	self:resetPreDelete()

	self.goPreDeleteCard = gohelper.findChild(go, "go_predeletecard")

	gohelper.setActive(self.goPreDeleteCard, false)

	self.goRedAndBlue = gohelper.findChild(go, "#go_Liangyue")
	self.goLyMask = gohelper.findChild(go, "#go_Liangyue/mask")
	self.goRed = gohelper.findChild(go, "#go_Liangyue/red")
	self.goBlue = gohelper.findChild(go, "#go_Liangyue/green")
	self.goBoth = gohelper.findChild(go, "#go_Liangyue/both")

	self:resetRedAndBlue()

	self._heatRoot = gohelper.findChild(go, "#go_heat")
	self.goBloodPool = gohelper.findChild(go, "blood_pool")
	self.xingtiTxt = gohelper.findChildText(go, "txt_xingti")
	self.xingtiGo = self.xingtiTxt.gameObject
	self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.None
	self.useSkin = false

	if self.handCardType == FightEnum.CardShowType.HandCard or self.handCardType == FightEnum.CardShowType.Operation or self.handCardType == FightEnum.CardShowType.PlayCard then
		local cardSkin = FightCardDataHelper.getCardSkin()

		if cardSkin == 672801 then
			self.useSkin = true
		end
	end

	if self.useSkin then
		local frontBgRoot = gohelper.create2d(go, "skinFrontBg")

		self.frontBgRoot = frontBgRoot

		gohelper.setActive(frontBgRoot, true)
		gohelper.setSibling(frontBgRoot, 5)

		local frontBgNormal = gohelper.create2d(frontBgRoot, "skinFrontBgNormal")
		local frontBgBigSkill = gohelper.create2d(frontBgRoot, "skinFrontBgBigSkill")

		self.frontBgNormal = frontBgNormal
		self.frontBgBigSkill = frontBgBigSkill
		self.imgFrontBgNormal = gohelper.onceAddComponent(frontBgNormal, gohelper.Type_Image)
		self.imgFrontBgBigSkill = gohelper.onceAddComponent(frontBgBigSkill, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(self.imgFrontBgNormal, "card_dz4", true)
		UISpriteSetMgr.instance:setFightSkillCardSprite(self.imgFrontBgBigSkill, "card_dz", true)
		recthelper.setAnchorY(frontBgNormal.transform, -14)
		recthelper.setAnchorY(frontBgBigSkill.transform, 20)

		local backBgRoot = gohelper.create2d(go, "skinBackBg")

		self.backBgRoot = backBgRoot

		gohelper.setActive(backBgRoot, true)
		gohelper.setSibling(backBgRoot, 0)

		local img = gohelper.onceAddComponent(backBgRoot, gohelper.Type_Image)

		UISpriteSetMgr.instance:setFightSkillCardSprite(img, "card_dz3", true)

		for i = 1, #self._innerStartGOs do
			local obj = self._innerStartGOs[i]
			local transform = obj.transform

			for index = 0, transform.childCount - 1 do
				local child = transform:GetChild(index)
				local childName = child.name
				local img = gohelper.onceAddComponent(child.gameObject, gohelper.Type_Image)

				if childName == "light" then
					UISpriteSetMgr.instance:setFightSkillCardSprite(img, "xx1", true)
				elseif childName == "lightblue" then
					UISpriteSetMgr.instance:setFightSkillCardSprite(img, "xx3", true)
				else
					UISpriteSetMgr.instance:setFightSkillCardSprite(img, "xx2", true)
				end
			end
		end

		for i = 0, 4 do
			gohelper.setActive(self.skillIconBg[i], false)
			gohelper.setActive(self.attributeBg[i], false)
		end
	end

	self.playedHideCardOpenAnim = false
end

function FightViewCardItem:changeTopLayoutAnchorYOffset(offset)
	local curAnchorX, curAnchorY = recthelper.getAnchor(self.goTopLayout.transform)

	self.srcAnchorY = self.srcAnchorY or curAnchorY

	recthelper.setAnchor(self.goTopLayout.transform, curAnchorX, self.srcAnchorY + offset)
end

function FightViewCardItem:initSuperimposeNode()
	self.goSuperimposeRoot = gohelper.findChild(self.go, "superimpose_root")
	self.simageRouge2SkillIcon = gohelper.findChildSingleImage(self.goSuperimposeRoot, "rouge2skill_icon")
	self.goRouge2SkillIcon = self.simageRouge2SkillIcon.gameObject
	self.imageRouge2SkillIcon = self.goRouge2SkillIcon:GetComponent(gohelper.Type_Image)
end

function FightViewCardItem:resetPreDelete()
	gohelper.setActive(self.goPreDeleteNormal, false)
	gohelper.setActive(self.goPreDeleteUnique, false)
	gohelper.setActive(self.goPreDeleteLeft, false)
	gohelper.setActive(self.goPreDeleteRight, false)
	gohelper.setActive(self.goPreDeleteBoth, false)
end

function FightViewCardItem:resetRedAndBlue()
	gohelper.setActive(self.goRedAndBlue, true)
	gohelper.setActive(self.goLyMask, false)
	gohelper.setActive(self.goRed, false)
	gohelper.setActive(self.goBlue, false)
	gohelper.setActive(self.goBoth, false)
end

function FightViewCardItem:addEventListeners()
	self:addEventCb(FightController.instance, FightEvent.ASFD_EmitterEnergyChange, self.onEmitterEnergyChange, self)
	self:addEventCb(FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)

	if self:checkCanShowHideCardEffect() then
		self:addEventCb(FightController.instance, FightEvent.OnAddHideCardBuff, self.onAddHideCardBuff, self)
		self:addEventCb(FightController.instance, FightEvent.OnRemoveHideCardBuff, self.OnRemoveHideCardBuff, self)
	end
end

function FightViewCardItem:onAddHideCardBuff()
	self.playedHideCardOpenAnim = false

	self:refreshCardIcon()
end

function FightViewCardItem:OnRemoveHideCardBuff()
	self:refreshCardIcon()
end

local hideCardVxPrefab = "ui/viewres/fight/fighttower/card_mshboss.prefab"

function FightViewCardItem:refreshHideCardVx()
	if not self:checkCanShowHideCardEffect() then
		return
	end

	if self.goHideCardVx then
		local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
		local isBigSkill = skillCardLv == FightEnum.UniqueSkillCardLv
		local hasHideCardVx

		if isBigSkill then
			hasHideCardVx = FightModel.instance.bigSkillIcon ~= nil
		else
			hasHideCardVx = FightModel.instance.smallSkillIcon ~= nil
		end

		gohelper.setActive(self.goHideCardVx, hasHideCardVx)
		gohelper.setActive(self.goHideCardVxNormal, hasHideCardVx and not isBigSkill)
		gohelper.setActive(self.goHideCardVxBigSkill, hasHideCardVx and isBigSkill)

		if hasHideCardVx and not self.playedHideCardOpenAnim then
			if isBigSkill then
				self.hideCardBigSkillAnim:Play("open")
			else
				self.hideCardNormalAnim:Play("open")
			end

			self.playedHideCardOpenAnim = true
		end
	else
		if self.hideVxLoader then
			return
		end

		self.hideVxLoader = MultiAbLoader.New()

		self.hideVxLoader:addPath(hideCardVxPrefab)
		self.hideVxLoader:startLoad(self.onHideCardVxLoaded, self)
	end
end

FightViewCardItem.HideCardVxGoName = "hideCardVx"

function FightViewCardItem:onHideCardVxLoaded()
	local sourceGo = self.hideVxLoader:getAssetItem(hideCardVxPrefab):GetResource()

	self.goHideCardVx = gohelper.clone(sourceGo, self.go, FightViewCardItem.HideCardVxGoName)
	self.goHideCardVxNormal = gohelper.findChild(self.goHideCardVx, "normal")

	local animGo = gohelper.findChild(self.goHideCardVxNormal, "ani")

	self.hideCardNormalAnim = ZProj.ProjAnimatorPlayer.Get(animGo)
	self.goHideCardVxBigSkill = gohelper.findChild(self.goHideCardVx, "ultimate")
	animGo = gohelper.findChild(self.goHideCardVxBigSkill, "ani")
	self.hideCardBigSkillAnim = ZProj.ProjAnimatorPlayer.Get(animGo)

	self:refreshHideCardVx()
end

function FightViewCardItem:onUpdateBuffActInfo(entityId, buffUid, buffActInfo)
	if buffActInfo.actId ~= FightEnum.BuffActId.NoUseCardEnergyRecordByRound then
		return
	end

	self:refreshXiTiSpecialSkill(self.entityId, self.skillId)
end

function FightViewCardItem:onEmitterEnergyChange()
	if not FightHelper.isASFDSkill(self.skillId) then
		return
	end

	self.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	if self._disappearFlow and self._disappearFlow.status == WorkStatus.Running then
		return
	end

	if self._dissolveFlow and self._dissolveFlow.status == WorkStatus.Running then
		return
	end

	AudioMgr.instance:trigger(20248003)

	self.asfdSkillAnimator = self.asfdSkillAnimator or self.goASFDSkill:GetComponent(gohelper.Type_Animator)

	self.asfdSkillAnimator:Play("aggrandizement", 0, 0)
end

function FightViewCardItem:resetAllNode()
	local count = self.tr.childCount

	for index = 1, count do
		local child = self.tr:GetChild(index - 1)

		gohelper.setActive(child.gameObject, false)
	end
end

function FightViewCardItem:updateItem(entityId, skillId, cardInfoMO)
	self.entityId = entityId
	self.skillId = skillId
	self._cardInfoMO = cardInfoMO

	self:resetAllNode()
	gohelper.setActive(self.go, true)
	gohelper.setActive(self.goTag, true)
	gohelper.setActive(self.goRedAndBlue, true)
	gohelper.setActive(self._layout, true)
	gohelper.setActive(self.frontBgRoot, true)
	gohelper.setActive(self.backBgRoot, true)

	self._canvasGroup.alpha = 1
	self.tagCanvas.alpha = 1

	if FightHelper.isBloodPoolSkill(skillId) then
		gohelper.setActive(self.frontBgRoot, false)

		return self:refreshBloodPoolSkill(entityId, skillId, cardInfoMO)
	end

	if FightHelper.isASFDSkill(skillId) then
		gohelper.setActive(self.frontBgRoot, false)

		return self:refreshASFDSkill(entityId, skillId, cardInfoMO)
	end

	if FightHelper.isPreDeleteSkill(skillId) then
		gohelper.setActive(self.frontBgRoot, false)

		return self:refreshPreDeleteSkill(entityId, skillId, cardInfoMO)
	end

	self:_hideAniEffect()
	self:refreshCardIcon()

	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
	local showStar = skillCardLv < FightEnum.UniqueSkillCardLv and skillCardLv > 0

	gohelper.setActive(self._starGO, showStar)

	self._starCanvas.alpha = 1

	for i, startGO in ipairs(self._innerStartGOs) do
		gohelper.setActive(startGO, i == skillCardLv)

		if self._starItemCanvas[i] then
			self._starItemCanvas[i].alpha = 1
		end
	end

	self:refreshTag()

	local skillCO = lua_skill.configDict[self.skillId]

	self._txt.text = skillCO.id .. "\nLv." .. skillCardLv

	local showBigSkillEffect = skillCardLv == FightEnum.UniqueSkillCardLv

	if self.useSkin then
		showBigSkillEffect = false
	end

	if skillCardLv == FightEnum.UniqueSkillCardLv and not self._uniqueCardEffect then
		local url = ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka)
		local assetItem = FightHelper.getPreloadAssetItem(url)

		self._uniqueCardEffect = gohelper.clone(assetItem:GetResource(url), self.go)
	end

	gohelper.setActive(self._uniqueCardEffect, showBigSkillEffect)
	gohelper.setActive(self.frontBgNormal, skillCardLv ~= FightEnum.UniqueSkillCardLv)
	gohelper.setActive(self.frontBgBigSkill, skillCardLv == FightEnum.UniqueSkillCardLv)
	gohelper.setActive(self._predisplay, self._cardInfoMO and self._cardInfoMO.tempCard)
	self:_showUpgradeEffect()
	self:_showEnchantsEffect()
	self:_showRouge2EnchantsEffect()
	self:_refreshGray()
	self:_refreshASFD()
	self:_refreshRouge2Music()
	self:_refreshPreDeleteArrow()
	self:showCardHeat()
	self:refreshXiTiSpecialSkill(entityId, skillId, cardInfoMO)
	self:refreshSuperimposeIcon()
end

function FightViewCardItem:refreshSuperimposeIcon()
	gohelper.setActive(self.goSuperimposeRoot, true)

	local isMusicSkill = FightRouge2MusicBehaviourHelper.isRouge2ClothMusicSkill(self.skillId)

	if not isMusicSkill then
		gohelper.setActive(self.goRouge2SkillIcon, false)

		return
	end

	gohelper.setActive(self.goRouge2SkillIcon, true)

	local co = lua_fight_rouge2_music_ball_skill.configDict[self.skillId]

	if not co then
		logError("fight_rouge2_music_ball_skill 表 未找到配置, skillId : " .. tostring(self.skillId))

		co = lua_fight_rouge2_music_ball_skill.configList[1]
	end

	local url = string.format("singlebg/rouge2/backpack/skill/%s.png", co.icon)

	self.simageRouge2SkillIcon:LoadImage(url, self.onLoadRouge2ClothSkillIconDone, self)
end

function FightViewCardItem:onLoadRouge2ClothSkillIconDone()
	self.imageRouge2SkillIcon:SetNativeSize()
end

function FightViewCardItem:refreshCardIcon()
	local skillCO = lua_skill.configDict[self.skillId]
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	for level, lvGO in pairs(self._lvGOs) do
		gohelper.setActive(lvGO, true)
		gohelper.setActiveCanvasGroup(lvGO, skillCardLv == level)
	end

	local targetIconUrl

	if self:checkCanShowHideCardEffect() then
		targetIconUrl = FightModel.instance:getHandCardSkillIcon(self.entityId, skillCO)
	else
		targetIconUrl = ResUrl.getSkillIcon(skillCO.icon)
	end

	for level, one in pairs(self._lvImgIcons) do
		if gohelper.isNil(self._lvImgComps[level].sprite) then
			one:UnLoadImage()
		elseif one.curImageUrl ~= targetIconUrl then
			one:UnLoadImage()
		end

		one:LoadImage(targetIconUrl)
	end

	self:refreshHideCardVx()
end

function FightViewCardItem:checkCanShowHideCardEffect()
	return self.handCardType == FightEnum.CardShowType.HandCard or self.handCardType == FightEnum.CardShowType.Operation
end

function FightViewCardItem:_onPcKeyAdapter()
	if self.showASFD and PCInputController.instance:getIsUse() and PlayerPrefsHelper.getNumber("keyTips", 0) ~= 0 then
		local pos = self.goASFD.transform.localPosition

		pos.y = 200
		self.goASFD.transform.localPosition = pos
	else
		local pos = self.goASFD.transform.localPosition

		pos.y = 170
		self.goASFD.transform.localPosition = pos
	end
end

function FightViewCardItem:refreshTag()
	local skillCO = lua_skill.configDict[self.skillId]
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
	local prefixStr = "attribute_"
	local tagWidth = 168
	local tagHeight = 56

	if self.useSkin then
		prefixStr = "v2a8_skin/attribute_"
		tagWidth = 180
		tagHeight = 64
	end

	local tagUrl = ResUrl.getAttributeIcon(prefixStr .. skillCO.showTag)

	self._tag:LoadImage(tagUrl)
	recthelper.setSize(self.tagTransform, tagWidth, tagHeight)

	local showTagPos = FightViewCardItem.TagPosForLvs[skillCardLv]

	if showTagPos then
		recthelper.setAnchor(self._tagRootTr, showTagPos[1], showTagPos[2])

		if self.useSkin then
			recthelper.setAnchorY(self._tagRootTr, -200)
		end
	end

	gohelper.setActive(self._tag.gameObject, skillCardLv < FightEnum.UniqueSkillCardLv)
end

function FightViewCardItem:showCardHeat()
	if self._cardInfoMO and self._cardInfoMO.heatId and self._cardInfoMO.heatId ~= 0 then
		self:setHeatRootVisible(true)

		if self._heatObj then
			self:_refreshCardHeat()
		elseif not self._loadHeat then
			self._loadHeat = true

			self._loader:loadAsset("ui/viewres/fight/fightheatview.prefab", self._onHeatLoadFinish, self)
		end
	else
		self:setHeatRootVisible(false)
	end
end

function FightViewCardItem:setHeatRootVisible(state)
	gohelper.setActive(self._heatRoot, state)
end

function FightViewCardItem:_refreshCardHeat()
	if self._cardInfoMO and self._cardInfoMO.heatId ~= 0 then
		local heatId = self._cardInfoMO.heatId
		local teamData = FightDataHelper.teamDataMgr.myData
		local data = teamData.cardHeat.values[heatId]

		if data then
			local offset = FightDataHelper.teamDataMgr.myCardHeatOffset[heatId] or 0

			self._heatText.text = Mathf.Clamp(data.value + offset, data.lowerLimit, data.upperLimit)
		else
			self._heatText.text = ""
		end
	end
end

function FightViewCardItem:_onHeatLoadFinish(success, loader)
	if not success then
		return
	end

	self._heatObj = gohelper.clone(loader:GetResource(), self._heatRoot)
	self._heatText = gohelper.findChildText(self._heatObj, "heatText")

	self:_refreshCardHeat()
end

function FightViewCardItem:_refreshPreDeleteArrow()
	local isHandCard = self.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(self.goPreDelete, isHandCard)

	if isHandCard then
		gohelper.setActive(self.goPreDeleteBoth, false)
		gohelper.setActive(self.goPreDeleteLeft, false)
		gohelper.setActive(self.goPreDeleteRight, false)

		local co = lua_fight_card_pre_delete.configDict[self.skillId]

		if co then
			local left = co.left > 0
			local right = co.right > 0

			if left and right then
				gohelper.setActive(self.goPreDeleteBoth, true)
			elseif left then
				gohelper.setActive(self.goPreDeleteLeft, true)
			elseif right then
				gohelper.setActive(self.goPreDeleteRight, true)
			end

			gohelper.setActive(self._starGO, false)
		end
	end
end

function FightViewCardItem:_refreshPreDeleteImage(needShowPreDeleteImage)
	local isHandCard = self.handCardType == FightEnum.CardShowType.HandCard

	gohelper.setActive(self.goPreDelete, isHandCard)

	if isHandCard then
		local usUniqueSkill = FightCardDataHelper.isBigSkill(self.skillId)

		gohelper.setActive(self.goPreDeleteNormal, not usUniqueSkill and needShowPreDeleteImage)
		gohelper.setActive(self.goPreDeleteUnique, usUniqueSkill and needShowPreDeleteImage)
	end
end

function FightViewCardItem:refreshPreDeleteSkill(entityId, skillId, cardInfoMO)
	gohelper.setActive(self.goPreDeleteCard, true)
	gohelper.setActive(self.goPreDeleteNormal, false)
	gohelper.setActive(self.goPreDeleteUnique, false)
	self:refreshTag()
	self:_refreshPreDeleteArrow()
end

function FightViewCardItem:refreshBloodPoolSkill(entityId, skillId, cardInfoMO)
	gohelper.setActive(self.goBloodPool, true)
	gohelper.setActive(self.goTag, true)
	gohelper.setActive(self._tag.gameObject, true)

	self.bloodPoolAnimator = self.bloodPoolAnimator or self.goBloodPool:GetComponent(gohelper.Type_Animator)

	if self.handCardType == FightEnum.CardShowType.Operation then
		self.bloodPoolAnimator:Play("open", 0, 0)
		AudioMgr.instance:trigger(20270007)
	else
		self.bloodPoolAnimator:Play("open", 0, 1)
	end

	self._tag:LoadImage(ResUrl.getAttributeIcon("blood_tex2"))

	local showTagPos = FightViewCardItem.TagPosForLvs[1]

	recthelper.setAnchor(self._tagRootTr, showTagPos[1], showTagPos[2])
end

function FightViewCardItem:refreshASFDSkill(entityId, skillId, cardInfoMO)
	gohelper.setActive(self.goASFDSkill, true)
	gohelper.setActive(self.goTag, true)
	gohelper.setActive(self._tag.gameObject, true)

	local url = ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon)

	self.asfdSkillSimage:LoadImage(url)

	self.asfdNumTxt.text = FightDataHelper.ASFDDataMgr:getEmitterEnergy(FightEnum.EntitySide.MySide)

	self._tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

	local showTagPos = FightViewCardItem.TagPosForLvs[1]

	recthelper.setAnchor(self._tagRootTr, showTagPos[1], showTagPos[2])
end

function FightViewCardItem:refreshXiTiSpecialSkill(entityId, skillId, cardInfoMO)
	if not FightHelper.isXiTiSpecialSkill(skillId) then
		gohelper.setActive(self.xingtiGo, false)

		return
	end

	gohelper.setActive(self.xingtiGo, true)

	self.xingtiTxt.text = FightASFDHelper.getLastRoundRecordCardEnergy()
end

function FightViewCardItem:updateResistanceByCardInfo(cardInfoMO)
	self._resistanceComp:updateByCardInfo(cardInfoMO)
end

function FightViewCardItem:updateResistanceByBeginRoundOp(fightBeginRoundOp)
	self._resistanceComp:updateByBeginRoundOp(fightBeginRoundOp)
end

function FightViewCardItem:updateResistanceBySkillDisplayMo(displayMo)
	self._resistanceComp:updateBySkillDisplayMo(displayMo)
end

function FightViewCardItem:detectShowBlueStar()
	local skillCardLv = self.entityId and self.skillId and FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	self:showBlueStar(skillCardLv)
end

function FightViewCardItem:showBlueStar(skillCardLv)
	if self._lightBlueObj then
		for i, v in ipairs(self._lightBlueObj) do
			gohelper.setActive(v.blue, false)
			gohelper.setActive(v.dark, true)
		end
	else
		self._lightBlueObj = {}
		self._lightBlueObj[1] = self:getUserDataTb_()
		self._lightBlueObj[1].blue = gohelper.findChild(self._innerStartGOs[1], "lightblue")
		self._lightBlueObj[1].dark = gohelper.findChild(self._innerStartGOs[1], "dark2")
		self._lightBlueObj[2] = self:getUserDataTb_()
		self._lightBlueObj[2].blue = gohelper.findChild(self._innerStartGOs[2], "lightblue")
		self._lightBlueObj[2].dark = gohelper.findChild(self._innerStartGOs[2], "dark3")
	end

	if skillCardLv == 1 or skillCardLv == 2 then
		local entityMO = FightDataHelper.entityMgr:getById(self.entityId)

		if entityMO and entityMO:hasBuffFeature(FightEnum.BuffFeature.SkillLevelJudgeAdd) then
			local tab = self._lightBlueObj[skillCardLv]

			gohelper.setActive(tab.blue, true)
			gohelper.setActive(tab.dark, false)
		end
	end
end

function FightViewCardItem:showPrecisionEffect()
	gohelper.setActive(self._precisionEffect, true)
end

function FightViewCardItem:hidePrecisionEffect()
	gohelper.setActive(self._precisionEffect, false)
end

local enchantId2EffectPath = {
	[FightEnum.EnchantedType.Frozen] = "ui/viewres/fight/card_freeze.prefab",
	[FightEnum.EnchantedType.Burn] = "ui/viewres/fight/card_flaring.prefab",
	[FightEnum.EnchantedType.Chaos] = "ui/viewres/fight/card_chaos.prefab",
	[FightEnum.EnchantedType.depresse] = "ui/viewres/fight/card_qmyj.prefab"
}

function FightViewCardItem:_showEnchantsEffect()
	gohelper.setActive(self._abandon, false)
	gohelper.setActive(self._blockadeTwo, false)
	gohelper.setActive(self._blockadeOne, false)
	gohelper.setActive(self._precision, false)
	gohelper.setActive(self._precisionEffect, false)

	if not self._cardInfoMO then
		return
	end

	local loadPaths = self:_refreshEnchantEffectActive()

	if #loadPaths > 0 then
		self._loader:loadListAsset(loadPaths, self._onEnchantEffectLoaded, self._onEnchantEffectsLoaded, self)
	end

	if self._cardInfoMO.enchants then
		for i, v in ipairs(self._cardInfoMO.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Discard then
				gohelper.setActive(self._abandon, true)
			elseif v.enchantId == FightEnum.EnchantedType.Blockade then
				local handCards = FightDataHelper.handCardMgr.handCard

				if self._cardInfoMO.clientData.custom_playedCard then
					gohelper.setActive(self._blockadeOne, true)
				elseif self._cardInfoMO.clientData.custom_handCardIndex then
					if self._cardInfoMO.clientData.custom_handCardIndex == 1 or self._cardInfoMO.clientData.custom_handCardIndex == #handCards then
						gohelper.setActive(self._blockadeOne, true)
					else
						gohelper.setActive(self._blockadeTwo, true)
					end
				else
					gohelper.setActive(self._blockadeOne, true)
				end
			elseif v.enchantId == FightEnum.EnchantedType.Precision then
				gohelper.setActive(self._precision, true)

				if self._cardInfoMO.clientData.custom_handCardIndex == 1 then
					FightController.instance:dispatchEvent(FightEvent.RefreshHandCardPrecisionEffect)
				end
			end
		end
	end
end

function FightViewCardItem:setRouge2TreasureRoot(go)
	self.goRouge2Treasure = go
end

function FightViewCardItem:_showRouge2EnchantsEffect(cardInfoMo)
	gohelper.setActive(self.goRouge2Double, false)
	gohelper.setActive(self.goRouge2Double_HandCard, false)
	gohelper.setActive(self.goRouge2Treasure, false)

	local cardInfo = cardInfoMo or self._cardInfoMO

	if not cardInfo then
		return
	end

	local enchants = cardInfo.enchants

	if not enchants then
		return
	end

	for _, v in ipairs(enchants) do
		if v.enchantId == FightEnum.EnchantedType.Rouge2_Treasure then
			if self.goRouge2Treasure then
				gohelper.setActive(self.goRouge2Treasure, true)

				if not self.rouge2TreasureLoader then
					self.rouge2TreasureLoader = PrefabInstantiate.Create(self.goRouge2Treasure)

					self.rouge2TreasureLoader:startLoad("ui/viewres/fight/fight_rouge2/fight_rouge2_treasurecarditem.prefab")
				end
			end
		elseif v.enchantId == FightEnum.EnchantedType.Rouge2_Double then
			if self.handCardType == FightEnum.CardShowType.HandCard then
				gohelper.setActive(self.goRouge2Double, false)
				gohelper.setActive(self.goRouge2Double_HandCard, true)
			else
				gohelper.setActive(self.goRouge2Double, true)
				gohelper.setActive(self.goRouge2Double_HandCard, false)
			end

			if not self.rouge2DoubleLoader then
				self.rouge2DoubleLoader = PrefabInstantiate.Create(self.goRouge2Double)

				self.rouge2DoubleLoader:startLoad("ui/viewres/fight/fight_rouge2/fight_rouge2_treasurecarditem2.prefab")
			end
		end
	end
end

function FightViewCardItem:_refreshEnchantEffectActive()
	self:_hideEnchantsEffect()

	self._enchantsEffect = self._enchantsEffect or {}

	local enchants = self._cardInfoMO.enchants or {}
	local loadPaths = {}

	for i, v in ipairs(enchants) do
		local enchantId = v.enchantId

		if self._enchantsEffect[enchantId] then
			for index, gameObject in ipairs(self._enchantsEffect[enchantId]) do
				gohelper.setActive(gameObject, true)
			end
		else
			local path = enchantId2EffectPath[enchantId]

			if path then
				table.insert(loadPaths, path)
			end
		end
	end

	return loadPaths
end

function FightViewCardItem:_hideEnchantsEffect()
	if self._enchantsEffect then
		for i, v in pairs(self._enchantsEffect) do
			for index, gameObject in ipairs(v) do
				gohelper.setActive(gameObject, false)
			end
		end
	end
end

function FightViewCardItem:_onEnchantEffectLoaded(success, loader)
	return
end

function FightViewCardItem:_onEnchantEffectsLoaded(fightLoaderList)
	for k, v in pairs(enchantId2EffectPath) do
		if not self._enchantsEffect[k] then
			local loader = fightLoaderList:getAssetItem(v)

			if loader then
				local tarPrefab = loader:GetResource()

				if self._lvGOs then
					self._enchantsEffect[k] = self:getUserDataTb_()

					for level, obj in pairs(self._lvGOs) do
						local clone = gohelper.clone(tarPrefab, gohelper.findChild(obj, "#cardeffect"))

						for index = 0, 4 do
							local lvObj = gohelper.findChild(clone, "lv" .. index)

							gohelper.setActive(lvObj, index == level)
						end

						table.insert(self._enchantsEffect[k], clone)
					end
				end
			end
		end
	end

	self:_refreshEnchantEffectActive()
end

function FightViewCardItem:_showUpgradeEffect()
	if lua_fight_upgrade_show_skillid.configDict[self.skillId] then
		if not self._upgradeEffects then
			self._loader:loadAsset("ui/viewres/fight/card_aggrandizement.prefab", self._onUpgradeEffectLoaded, self)

			return
		end

		for i, v in ipairs(self._upgradeEffects) do
			gohelper.setActive(v, false)
			gohelper.setActive(v, true)
		end
	else
		self:_hideUpgradeEffects()
	end
end

function FightViewCardItem:_hideUpgradeEffects()
	if self._upgradeEffects then
		for i, v in ipairs(self._upgradeEffects) do
			gohelper.setActive(v, false)
		end
	end
end

function FightViewCardItem:_onUpgradeEffectLoaded(success, loader)
	if not success then
		return
	end

	if self._upgradeEffects then
		return
	end

	self._upgradeEffects = self:getUserDataTb_()

	local tarPrefab = loader:GetResource()

	if self._lvGOs and tarPrefab then
		for level, v in pairs(self._lvGOs) do
			local clone = gohelper.clone(tarPrefab, gohelper.findChild(v, "#cardeffect"))

			for index = 0, 4 do
				local lvObj = gohelper.findChild(clone, "lv" .. index)

				gohelper.setActive(lvObj, index == level)
			end

			table.insert(self._upgradeEffects, clone)
		end
	end

	self:_showUpgradeEffect()
end

function FightViewCardItem:showCountPart(count)
	gohelper.setActive(self._countRoot, true)

	self._countText.text = luaLang("multiple") .. count
end

function FightViewCardItem:changeToTempCard()
	gohelper.setActive(self._predisplay, true)
end

function FightViewCardItem:dissolveCard(scale, tarGameObject)
	if not self.go.activeInHierarchy then
		return
	end

	if FightHelper.isASFDSkill(self.skillId) then
		return self:disappearCard()
	end

	if FightHelper.isPreDeleteSkill(self.skillId) then
		return self:disappearCard()
	end

	if FightHelper.isBloodPoolSkill(self.skillId) then
		return self:disappearCard()
	end

	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	local context = self:getUserDataTb_()

	context.dissolveScale = scale or 1

	local tab = self:getUserDataTb_()

	tarGameObject = tarGameObject or self.go

	table.insert(tab, tarGameObject)

	context.dissolveSkillItemGOs = tab

	if not self._dissolveFlow then
		self._dissolveFlow = FlowSequence.New()

		self._dissolveFlow:addWork(FightCardDissolveEffect.New())
	else
		self._dissolveFlow:stop()
	end

	self:_hideAllEffect()
	self._dissolveFlow:start(context)
end

function FightViewCardItem:disappearCard()
	if not self.go.activeInHierarchy then
		return
	end

	self:setASFDActive(false)
	self:revertASFDSkillAnimator()

	local context = self:getUserDataTb_()

	context.hideSkillItemGOs = self:getUserDataTb_()

	table.insert(context.hideSkillItemGOs, self.go)

	if not self._disappearFlow then
		self._disappearFlow = FlowSequence.New()

		self._disappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	else
		self._disappearFlow:stop()
	end

	self._disappearFlow:start(context)
end

function FightViewCardItem:revertASFDSkillAnimator()
	if not FightHelper.isASFDSkill(self.skillId) then
		return
	end

	if self.asfdSkillAnimator then
		self.asfdSkillAnimator:Play("open", 0, 0)
	end
end

function FightViewCardItem:playUsedCardDisplay(tipsGO)
	if not self.go.activeInHierarchy then
		return
	end

	if not self._cardDisplayFlow then
		self._cardDisplayFlow = FlowSequence.New()

		self._cardDisplayFlow:addWork(FightCardDisplayEffect.New())
	end

	local context = self:getUserDataTb_()

	context.skillTipsGO = tipsGO
	context.skillItemGO = self.go

	self._cardDisplayFlow:start(context)
end

function FightViewCardItem:playUsedCardFinish(tipsGO, waitingAreaGO)
	if not self.go.activeInHierarchy then
		return
	end

	if not self._cardDisplayEndFlow then
		self._cardDisplayEndFlow = FlowSequence.New()

		self._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())
	end

	local context = self:getUserDataTb_()

	context.skillTipsGO = tipsGO
	context.skillItemGO = self.go
	context.waitingAreaGO = waitingAreaGO

	self._cardDisplayEndFlow:start(context)
end

function FightViewCardItem:playCardLevelChange(cardData, oldSkillId, failType)
	if not self._cardInfoMO then
		return
	end

	if not self.go.activeInHierarchy then
		return
	end

	self._cardInfoMO = cardData or self._cardInfoMO

	local oldLevel = FightConfig.instance:getSkillLv(oldSkillId)
	local newLevel = FightConfig.instance:getSkillLv(self._cardInfoMO.skillId)

	if not self._cardLevelChangeFlow then
		self._cardLevelChangeFlow = FlowSequence.New()

		self._cardLevelChangeFlow:addWork(FightCardChangeEffect.New())
		self._cardLevelChangeFlow:registerDoneListener(self._onCardLevelChangeFlowDone, self)
	else
		oldLevel = self._cardLevelChangeFlow.status == WorkStatus.Running and self._cardLevelChangeFlow.context and self._cardLevelChangeFlow.context.oldCardLevel or oldLevel

		self._cardLevelChangeFlow:stop()
	end

	local context = self:getUserDataTb_()

	context.skillId = self._cardInfoMO.skillId
	context.entityId = self._cardInfoMO.uid
	context.oldCardLevel = oldLevel
	context.newCardLevel = newLevel
	context.cardItem = self
	context.failType = failType

	self._cardLevelChangeFlow:start(context)

	if oldLevel <= newLevel then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_cardstarup)
	else
		AudioMgr.instance:trigger(20211403)
	end
end

function FightViewCardItem:_refreshGray()
	if self._cardInfoMO and self._cardInfoMO.status == FightEnum.CardInfoStatus.STATUS_PLAYSETGRAY then
		gohelper.setActive(self._cardMask, true)

		local entityId = self._cardInfoMO.uid
		local skillId = self._cardInfoMO.skillId
		local skillCardLv = FightCardDataHelper.getSkillLv(entityId, skillId)
		local isBigSkill = FightCardDataHelper.isBigSkill(skillId)

		for i, v in ipairs(self._maskList) do
			if i < 4 then
				gohelper.setActive(v, i == skillCardLv)
			else
				gohelper.setActive(v, isBigSkill)
			end
		end
	else
		gohelper.setActive(self._cardMask, false)
	end
end

function FightViewCardItem:playCardAroundSetGray()
	self:_refreshGray()
end

function FightViewCardItem:playChangeRankFail(failType)
	if self._cardInfoMO then
		self:playCardLevelChange(self._cardInfoMO, self._cardInfoMO.skillId, failType)
	end
end

function FightViewCardItem:_refreshRouge2Music()
	gohelper.setActive(self.goTopLayout, true)

	if not self.showRouge2Music then
		gohelper.setActive(self.goRouge2Music, false)

		return
	end

	local canShowRouge2Music = self.handCardType == FightEnum.CardShowType.HandCard

	if not canShowRouge2Music then
		gohelper.setActive(self.goRouge2Music, false)

		return
	end

	local musicNote = self._cardInfoMO and self._cardInfoMO.musicNote
	local musicType = musicNote and musicNote.type

	if not musicType or musicType == FightEnum.Rouge2MusicType.None then
		gohelper.setActive(self.goRouge2Music, false)

		return
	end

	local co = FightConfig.instance:getRouge2MusicCo(musicType)

	gohelper.setActive(self.goRouge2Music, true)
	UISpriteSetMgr.instance:setFightSprite(self.imageRouge2Music, co.icon1)
end

function FightViewCardItem:setRouge2MusicActive(active)
	self.showRouge2Music = active

	self:_refreshRouge2Music()
end

function FightViewCardItem:setASFDActive(active)
	self.showASFD = active

	self:_refreshASFD()
end

function FightViewCardItem:_refreshASFD()
	gohelper.setActive(self.goTopLayout, true)

	local showASFD = self.showASFD and self._cardInfoMO and self._cardInfoMO.energy > 0

	gohelper.setActive(self.goASFD, showASFD)

	if showASFD then
		self.txtASFDEnergy.text = self._cardInfoMO.energy
	end
end

function FightViewCardItem:changeEnergy()
	gohelper.setActive(self.goTopLayout, true)

	local showASFD = self.showASFD and self._cardInfoMO and self._cardInfoMO.energy > 0

	gohelper.setActive(self.goASFD, showASFD)

	if showASFD then
		self.txtASFDEnergy.text = self._cardInfoMO.energy
		self.asfdAnimator = self.asfdAnimator or self.goASFD:GetComponent(gohelper.Type_Animator)

		self.asfdAnimator:Play("add", 0, 0)
	end
end

function FightViewCardItem:_allocateEnergyDone()
	gohelper.setActive(self.goTopLayout, true)

	local showASFD = self.showASFD and self._cardInfoMO and self._cardInfoMO.energy > 0

	gohelper.setActive(self.goASFD, showASFD)

	if showASFD then
		self.txtASFDEnergy.text = self._cardInfoMO.energy
		self.asfdAnimator = self.asfdAnimator or self.goASFD:GetComponent(gohelper.Type_Animator)

		self.asfdAnimator:Play("open", 0, 0)
	end
end

function FightViewCardItem:hideTopLayout()
	gohelper.setActive(self.goTopLayout, false)
end

function FightViewCardItem:showTopLayout()
	gohelper.setActive(self.goTopLayout, true)
end

function FightViewCardItem:playASFDAnim(animName)
	if self.goASFD.activeSelf then
		self.asfdAnimator = self.asfdAnimator or self.goASFD:GetComponent(gohelper.Type_Animator)

		self.asfdAnimator:Play(animName, 0, 0)
	end
end

function FightViewCardItem:_onCardLevelChangeFlowDone()
	self:updateItem(self._cardInfoMO.uid, self._cardInfoMO.skillId, self._cardInfoMO)
	FightController.instance:dispatchEvent(FightEvent.CardLevelChangeDone, self._cardInfoMO)
	self:detectShowBlueStar()
end

function FightViewCardItem:playCardAni(aniPath, aniname)
	self._cardAniName = aniname or UIAnimationName.Open

	self._loader:loadAsset(aniPath, self._onCardAniLoaded, self)
end

function FightViewCardItem:_onCardAniLoaded(success, loader)
	if not success then
		return
	end

	if not self._cardAniName then
		self:_hideAniEffect()

		return
	end

	self._cardAni.runtimeAnimatorController = loader:GetResource()
	self._cardAni.enabled = true
	self._cardAni.speed = FightModel.instance:getUISpeed()

	SLFramework.AnimatorPlayer.Get(self.go):Play(self._cardAniName, self.onCardAniFinish, self)
end

function FightViewCardItem:onCardAniFinish()
	self:_hideAniEffect()
	self:hideCardAppearEffect()
end

function FightViewCardItem:_hideAniEffect()
	self._cardAniName = nil
	self._cardAni.enabled = false

	gohelper.setActive(gohelper.findChild(self.go, "vx_balance"), false)
end

function FightViewCardItem:playAppearEffect()
	gohelper.setActive(self._cardAppearEffectRoot, true)

	if not self._appearEffect then
		if self._appearEffectLoadStart then
			return
		end

		self._appearEffectLoadStart = true

		self._loader:loadAsset("ui/viewres/fight/card_appear.prefab", self._onAppearEffectLoaded, self)
	else
		self:showAppearEffect()
	end
end

function FightViewCardItem:_onAppearEffectLoaded(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()

	self._appearEffect = gohelper.clone(tarPrefab, self._cardAppearEffectRoot)

	gohelper.addChild(self._cardAppearEffectRoot.transform.parent.parent.gameObject, self._cardAppearEffectRoot)
	self:showAppearEffect()
end

function FightViewCardItem:showAppearEffect()
	local isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	gohelper.setActive(gohelper.findChild(self._appearEffect, "nomal_skill"), not isBigSkill)
	gohelper.setActive(gohelper.findChild(self._appearEffect, "ultimate_skill"), isBigSkill)
end

function FightViewCardItem:hideCardAppearEffect()
	gohelper.setActive(self._cardAppearEffectRoot, false)
end

function FightViewCardItem:getASFDScreenPos()
	self.rectTrASFD = self.rectTrASFD or self.goASFD:GetComponent(gohelper.Type_RectTransform)

	return recthelper.uiPosToScreenPos2(self.rectTrASFD)
end

function FightViewCardItem:setActiveRed(active)
	gohelper.setActive(self.goRed, active)
	self:refreshLyMaskActive()
end

function FightViewCardItem:setActiveBlue(active)
	gohelper.setActive(self.goBlue, active)
	self:refreshLyMaskActive()
end

function FightViewCardItem:setActiveBoth(active)
	gohelper.setActive(self.goBoth, active)
	self:refreshLyMaskActive()
end

function FightViewCardItem:refreshLyMaskActive()
	local showMask = self.goRed.activeInHierarchy or self.goBlue.activeInHierarchy or self.goBoth.activeInHierarchy

	gohelper.setActive(self.goLyMask, showMask)
end

function FightViewCardItem:releaseEffectFlow()
	if self._cardLevelChangeFlow then
		self._cardLevelChangeFlow:unregisterDoneListener(self._onCardLevelChangeFlowDone, self)
		self._cardLevelChangeFlow:stop()

		self._cardLevelChangeFlow = nil
	end

	if self._dissolveFlow then
		self._dissolveFlow:stop()

		self._dissolveFlow = nil
	end

	if self._cardDisplayFlow then
		self._cardDisplayFlow:stop()

		self._cardDisplayFlow = nil
	end

	if self._cardDisplayEndFlow then
		self._cardDisplayEndFlow:stop()

		self._cardDisplayEndFlow = nil
	end

	if self._disappearFlow then
		if not gohelper.isNil(self.go) then
			gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup).alpha = 1
		end

		self._disappearFlow:stop()

		self._disappearFlow = nil
	end
end

function FightViewCardItem:onDestroy()
	self.simageRouge2SkillIcon:UnLoadImage()

	if self._loader then
		self._loader:disposeSelf()

		self._loader = nil
	end

	if self.hideVxLoader then
		self.hideVxLoader:dispose()

		self.hideVxLoader = nil
	end

	self:releaseEffectFlow()

	for skillCardLv, lvGO in pairs(self._lvGOs) do
		self._lvImgIcons[skillCardLv]:UnLoadImage()
	end

	self._tag:UnLoadImage()
	self:clearAlfEffect()
end

function FightViewCardItem:_hideAllEffect()
	self:_hideUpgradeEffects()
	self:_hideEnchantsEffect()
	gohelper.setActive(self.goPreDelete, false)
end

FightViewCardItem.AlfLoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}

function FightViewCardItem:tryPlayAlfEffect()
	if not self._cardInfoMO then
		return
	end

	if not FightHeroALFComp.ALFSkillDict[self._cardInfoMO.clientData.custom_fromSkillId] then
		return
	end

	self.showAlfEffectIng = true

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectAppear, self)

	if self.alfLoadStatus == FightViewCardItem.AlfLoadStatus.Loaded then
		self:_tryPlayAlfEffect()
	elseif self.alfLoadStatus == FightViewCardItem.AlfLoadStatus.Loading then
		-- block empty
	else
		self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.Loading
		self.alfLoader = PrefabInstantiate.Create(self.tr.parent.gameObject)

		local res = FightHeroSpEffectConfig.instance:getAlfCardAddEffect()

		self.alfLoader:startLoad(res, self.onLoadedAlfEffect, self)
	end
end

function FightViewCardItem:onLoadedAlfEffect()
	self.goAlfAddCardEffect = self.alfLoader:getInstGO()
	self.goAlfAddCardAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goAlfAddCardEffect)
	self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.Loaded

	self:_tryPlayAlfEffect()
end

function FightViewCardItem:_tryPlayAlfEffect()
	if not self.goAlfAddCardAnimatorPlayer then
		return
	end

	gohelper.setActive(self.go, false)
	gohelper.setActive(self.goAlfAddCardEffect, true)
	self.goAlfAddCardAnimatorPlayer:Play("open", self.playAlfCloseAnim, self)
end

function FightViewCardItem:playAlfCloseAnim()
	self.goAlfAddCardAnimatorPlayer:Play("close", self.playAlfCloseAnimDone, self)
	TaskDispatcher.runDelay(self.showCardGo, self, 0.2 / FightModel.instance:getUISpeed())
end

function FightViewCardItem:showCardGo()
	gohelper.setActive(self.go, true)
	self:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
end

function FightViewCardItem:playAlfCloseAnimDone()
	gohelper.setActive(self.goAlfAddCardEffect, false)

	self.showAlfEffectIng = false

	FightController.instance:dispatchEvent(FightEvent.ALF_AddCardEffectEnd, self)
end

function FightViewCardItem:showHightLightEffect(bShow)
	if self.highlightEffect then
		for i, v in ipairs(self.highlightEffect) do
			if v then
				gohelper.setActive(v, bShow)
			end
		end
	end
end

function FightViewCardItem:clearAlfEffect()
	if self.alfLoader then
		self.alfLoader:dispose()

		self.alfLoader = nil
	end

	self.alfLoadStatus = FightViewCardItem.AlfLoadStatus.None
	self.goAlfAddCardEffect = nil

	if self.goAlfAddCardAnimatorPlayer then
		self.goAlfAddCardAnimatorPlayer:Stop()

		self.goAlfAddCardAnimatorPlayer = nil
	end

	if self.rouge2TreasureLoader then
		self.rouge2TreasureLoader:dispose()

		self.rouge2TreasureLoader = nil
	end

	if self.rouge2DoubleLoader then
		self.rouge2DoubleLoader:dispose()

		self.rouge2DoubleLoader = nil
	end

	TaskDispatcher.cancelTask(self.showCardGo, self)
end

return FightViewCardItem
