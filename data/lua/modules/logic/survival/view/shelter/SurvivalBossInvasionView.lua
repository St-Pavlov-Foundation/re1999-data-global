-- chunkname: @modules/logic/survival/view/shelter/SurvivalBossInvasionView.lua

module("modules.logic.survival.view.shelter.SurvivalBossInvasionView", package.seeall)

local SurvivalBossInvasionView = class("SurvivalBossInvasionView", LuaCompBase)

function SurvivalBossInvasionView:ctor(posType)
	self.posType = posType
end

function SurvivalBossInvasionView:init(viewGO)
	self.viewGO = viewGO
	self.pos_mainview = gohelper.findChild(self.viewGO, "pos_mainview")
	self.pos_teamview = gohelper.findChild(self.viewGO, "pos_teamview")
	self.go_boss = gohelper.findChild(self.viewGO, "#go_BossBuff")
	self.go_monster = gohelper.findChildButtonWithAudio(self.go_boss, "#go_monster")
	self.go_monsterHeadIcon = gohelper.findChildSingleImage(self.go_boss, "#go_monster/#go_monsterHeadIcon")
	self.go_eff_weak = gohelper.findChild(self.go_boss, "#go_monster/#go_eff_weak")
	self.go_debuff = gohelper.findChild(self.go_boss, "#go_monster/#go_eff_weak/#go_debuff")
	self.txt_LimitTime = gohelper.findChildTextMesh(self.go_boss, "#go_monster/#txt_LimitTime")
	self.go_icon_Limit = gohelper.findChild(self.go_boss, "#go_monster/#txt_LimitTime/icon")
	self.txt_noIcon = gohelper.findChildTextMesh(self.go_boss, "#go_monster/#txt_noIcon")
	self.txt_score = gohelper.findChildTextMesh(self.go_boss, "Content/score/#txt_score")
	self.go_buff = gohelper.findChild(self.go_boss, "Content/#go_buff")
	self.go_Content = gohelper.findChild(self.go_boss, "Content")
	self.layoutContent = self.go_Content:GetComponent(gohelper.Type_VerticalLayoutGroup)
	self.scrollBar = gohelper.findChildScrollbar(self.go_boss, "Content/Scrollbar")
	self.image_progress = gohelper.findChildImage(self.go_boss, "Content/#image_progress")
	self.go_tips = gohelper.findChild(self.viewGO, "#go_tips")
	self.go_tips_layout = gohelper.findChild(self.go_tips, "layout")
	self.btn_close_tips = gohelper.findChildButton(self.go_tips, "#btn_close")
	self.txt_desc = gohelper.findChildTextMesh(self.go_tips, "layout/#txt_desc")
	self.txt_condition_tips = gohelper.findChildTextMesh(self.go_tips, "layout/#txt_condition")

	gohelper.setActive(self.go_buff, false)

	self.customItems = {}
	self.posType = self.posType or 1

	if self.posType == 2 then
		self.go_boss.transform:SetParent(self.pos_teamview.transform, false)
	else
		self.go_boss.transform:SetParent(self.pos_mainview.transform, false)
	end
end

function SurvivalBossInvasionView:addEventListeners()
	self:addClickCb(self.go_monster, self.onClickBoss, self)
	self:addClickCb(self.btn_close_tips, self.onCloseTip, self)
	self:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self:addEventCb(SurvivalController.instance, SurvivalEvent.AbandonFight, self.onAbandonFight, self)
	self:addEventCb(SurvivalController.instance, SurvivalEvent.OnDelayPopupFinishEvent, self.onDelayPopupFinishEvent, self)
end

function SurvivalBossInvasionView:onStart()
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	self.clientMo = self.weekInfo.clientData

	self:refresh()
	self:refreshDecoding(false)
	self:refreshList(false)
end

function SurvivalBossInvasionView:onDestroy()
	if self.textTweenId then
		ZProj.TweenHelper.KillById(self.textTweenId)

		self.textTweenId = nil
	end

	if self.progressTweenId then
		ZProj.TweenHelper.KillById(self.progressTweenId)

		self.progressTweenId = nil
	end
end

function SurvivalBossInvasionView:onShelterBagUpdate()
	self:refreshDecoding(true)
	self.clientMo:saveDataToServer()
end

function SurvivalBossInvasionView:onAbandonFight()
	self:refresh()
	self:refreshDecoding(false)
	self:refreshList(false)
end

function SurvivalBossInvasionView:onDelayPopupFinishEvent()
	self:refreshDecoding(true)
	self:refreshList(true)
end

function SurvivalBossInvasionView:onCloseTip()
	gohelper.setActive(self.go_tips, false)
end

function SurvivalBossInvasionView:refresh()
	self.intrudeBox = self.weekInfo.intrudeBox
	self.fight = self.weekInfo:getMonsterFight()

	if self.fight.fightId <= 0 then
		gohelper.setActive(self.go_boss, false)

		return
	end

	gohelper.setActive(self.go_boss, true)

	self.cleanPoints = self.fight.cleanPoints

	local smallIcon = self.fight.fightCo.smallheadicon

	if smallIcon then
		self.go_monsterHeadIcon:LoadImage(ResUrl.monsterHeadIcon(smallIcon))
	end

	local curDay = self.weekInfo.day
	local createDay = self.intrudeBox:getNextBossCreateDay(curDay)
	local remain = createDay - curDay

	gohelper.setActive(self.go_icon_Limit, remain > 0)

	if remain <= 0 then
		gohelper.setActive(self.txt_noIcon.gameObject, true)
		gohelper.setActive(self.txt_LimitTime.gameObject, false)

		self.txt_noIcon.text = luaLang("survival_mainview_monster_fight")
	else
		gohelper.setActive(self.txt_noIcon.gameObject, false)
		gohelper.setActive(self.txt_LimitTime.gameObject, true)

		self.txt_LimitTime.text = string.format("%s%s", remain, luaLang("time_day"))
	end
end

function SurvivalBossInvasionView:refreshDecoding(isCheckChange)
	if self.fight.fightId <= 0 then
		return
	end

	local clientData = self.clientMo.data

	self.decodingCurNum = self.weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(SurvivalEnum.CurrencyType.Decoding)

	local decodingItemNum = clientData.decodingItemNum

	self.txt_score.text = string.format("<#FF8640>%s</color>/%s", decodingItemNum, self.fight:getMaxCleanPoint())

	if isCheckChange then
		if decodingItemNum < self.decodingCurNum then
			self.textTweenId = ZProj.TweenHelper.DOTweenFloat(decodingItemNum, self.decodingCurNum, 1.5, self.onTween, self.onTweenFinish, self, nil, EaseType.OutQuart)

			self.clientMo:setDecodingItemNum(self.decodingCurNum)
		elseif decodingItemNum > self.decodingCurNum then
			self.txt_score.text = string.format("<#FF8640>%s</color>/%s", self.decodingCurNum, self.fight:getMaxCleanPoint())

			self.clientMo:setDecodingItemNum(self.decodingCurNum)
		end
	elseif not isCheckChange and decodingItemNum > self.decodingCurNum then
		self.txt_score.text = string.format("<#FF8640>%s</color>/%s", self.decodingCurNum, self.fight:getMaxCleanPoint())

		self.clientMo:setDecodingItemNum(self.decodingCurNum)
	end
end

function SurvivalBossInvasionView:onTween(value)
	self.txt_score.text = string.format("<#FF8640>%s</color>/%s", math.floor(value), self.fight:getMaxCleanPoint())
end

function SurvivalBossInvasionView:onTweenFinish()
	self:onTween(self.decodingCurNum)
end

function SurvivalBossInvasionView:refreshList(isCheckChange)
	if self.fight.fightId <= 0 then
		return
	end

	local clientData = self.clientMo.data
	local intrudeSchemeMos = self.fight.intrudeSchemeMos

	self.survivalIntrudeSchemeMo = {}

	for i = #intrudeSchemeMos, 1, -1 do
		table.insert(self.survivalIntrudeSchemeMo, intrudeSchemeMos[i])
	end

	self.repressNum = 0

	for i, mo in ipairs(intrudeSchemeMos) do
		if mo.survivalIntrudeScheme.repress then
			self.repressNum = self.repressNum + 1
		end
	end

	local curIsBossWeak = self.repressNum > 0

	gohelper.setActive(self.go_eff_weak, curIsBossWeak)

	if curIsBossWeak and isCheckChange and curIsBossWeak and clientData.isBossWeak ~= curIsBossWeak then
		gohelper.setActive(self.go_debuff, true)
		self.clientMo:setIsBossWeak(curIsBossWeak)
	end

	local customItemAmount = #self.customItems
	local listLength = #self.survivalIntrudeSchemeMo

	for i = 1, listLength do
		local mo = self.survivalIntrudeSchemeMo[i]

		if customItemAmount < i then
			local obj = gohelper.clone(self.go_buff, self.go_Content)

			gohelper.setActive(obj, true)

			local t = self:getUserDataTb_()

			t.imgIcon = obj:GetComponent(gohelper.Type_Image)
			t.btnClick = gohelper.findButtonWithAudio(obj)
			t.anim = gohelper.findComponentAnim(obj)

			self:addClickCb(t.btnClick, self.onClickCustomItem, self, {
				mo = mo,
				trans = t.imgIcon.transform
			})

			self.customItems[i] = t
		end

		self:refreshCustomItems(self.customItems[i], mo)

		local curIsRepress = mo.survivalIntrudeScheme.repress
		local isRepress = self.clientMo:getBossRepress(self.fight.fightId, mo.survivalIntrudeScheme.id)

		if isCheckChange and curIsRepress ~= isRepress then
			if curIsRepress then
				self.customItems[i].anim:Play("open", 0, 0)
			end

			self.clientMo:setBossRepress(self.fight.fightId, mo.survivalIntrudeScheme.id)
		end
	end

	for i = listLength + 1, customItemAmount do
		self.customItems[i]:setData(nil)
	end

	local itemH = 92
	local dur = self.layoutContent.spacing
	local progressOffsetH = 9
	local num = #intrudeSchemeMos
	local progressH = itemH * num + (num - 1) * dur + progressOffsetH
	local perClip = progressOffsetH / progressH
	local index = self.repressNum
	local h = itemH * index + (index - 1) * dur
	local per = h / progressH

	self.curRepressProgress = perClip + per

	local bossRepressProgress = clientData.bossRepressProgress

	self.image_progress.fillAmount = bossRepressProgress

	self.scrollBar:SetValue(bossRepressProgress)

	if isCheckChange then
		if bossRepressProgress < self.curRepressProgress then
			self.progressTweenId = ZProj.TweenHelper.DOTweenFloat(bossRepressProgress, self.curRepressProgress, 1.5, self.onProgressTween, self.onProgressTweenFinish, self, nil, EaseType.OutQuart)

			self.clientMo:setBossRepressProgress(self.curRepressProgress)
		elseif bossRepressProgress > self.curRepressProgress then
			self.image_progress.fillAmount = self.curRepressProgress

			self.clientMo:setBossRepressProgress(self.curRepressProgress)
		end
	elseif not isCheckChange and bossRepressProgress > self.curRepressProgress then
		self.image_progress.fillAmount = self.curRepressProgress

		self.clientMo:setBossRepressProgress(self.curRepressProgress)
	end
end

function SurvivalBossInvasionView:onProgressTween(value)
	self.image_progress.fillAmount = value

	self.scrollBar:SetValue(value)
end

function SurvivalBossInvasionView:onProgressTweenFinish()
	self:onProgressTween(self.curRepressProgress)
end

function SurvivalBossInvasionView:refreshCustomItems(t, mo)
	local path = mo:getDisplayIcon()

	UISpriteSetMgr.instance:setSurvivalSprite(t.imgIcon, path)
end

function SurvivalBossInvasionView:onClickCustomItem(param)
	local mo = param.mo
	local trans = param.trans
	local worldPos = trans.position
	local anchorPos = recthelper.rectToRelativeAnchorPos(worldPos, self.go_tips.transform)
	local x = anchorPos.x - 66

	if self.posType == 2 then
		x = anchorPos.x + 66 + recthelper.getWidth(self.go_tips_layout.transform)
	end

	recthelper.setAnchor(self.go_tips_layout.transform, x, anchorPos.y)
	gohelper.setActive(self.go_tips, true)

	self.txt_desc.text = mo.intrudeSchemeCfg.desc

	if mo.survivalIntrudeScheme.repress then
		self.txt_condition_tips.text = luaLang("SurvivalBossInvasionView_1")
	else
		self.txt_condition_tips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalBossInvasionView_2"), {
			mo.point
		})
	end
end

function SurvivalBossInvasionView:onClickBoss()
	SurvivalStatHelper.instance:statBtnClick("onClickBoss", "SurvivalBossInvasionView")
	ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
		showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Normal
	})
end

return SurvivalBossInvasionView
