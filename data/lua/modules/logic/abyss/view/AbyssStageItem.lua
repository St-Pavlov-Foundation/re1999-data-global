-- chunkname: @modules/logic/abyss/view/AbyssStageItem.lua

module("modules.logic.abyss.view.AbyssStageItem", package.seeall)

local AbyssStageItem = class("AbyssStageItem", LuaCompBase)

function AbyssStageItem:init(go)
	self.viewGO = go
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._gostarlayout = gohelper.findChild(self.viewGO, "#go_starlayout")
	self._gostargroup = gohelper.findChild(self.viewGO, "#go_starlayout/#go_stargroup")
	self._txtcliptitle = gohelper.findChildText(self.viewGO, "#txt_cliptitle")
	self._gocurherogroup = gohelper.findChild(self.viewGO, "#go_curherogroup")
	self._goherogItem = gohelper.findChild(self.viewGO, "#go_curherogroup/#go_herogItem")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "#go_curherogroup/#go_herogItem/#simage_hero")
	self._txtstarMaxtxt = gohelper.findChildText(self.viewGO, "#txt_starMaxtxt")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AbyssStageItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AbyssStageItem:_btnclickOnClick()
	if not ActivityModel.instance:isActOnLine(self.actId) then
		return
	end

	local param = {}

	param.actId = self.actId
	param.stageId = self.stageId

	ViewMgr.instance:openView(ViewName.AbyssStageDetailView, param)
end

function AbyssStageItem:_editableInitView()
	self._goPlayerBg = gohelper.findChild(self.viewGO, "img_playerbg")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._starItemList = self:getUserDataTb_()
end

function AbyssStageItem:setInfo(stageConfig)
	local activityId = stageConfig.activityId
	local stageId = stageConfig.stage

	self.actId = activityId
	self.stageId = stageId
	self.stageConfig = stageConfig

	self:refreshUI()
end

function AbyssStageItem:refreshUI()
	local stageConfig = self.stageConfig
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)

	self._txtcliptitle.text = episodeConfig.name

	local stageInfo = AbyssModel.instance:getStageInfoMo(self.actId, self.stageId)

	self.stageInfo = stageInfo

	local haveChallenge = stageInfo:isChallenged()

	self.haveChallenge = haveChallenge

	gohelper.setActive(self._gocurherogroup, false)
	gohelper.setActive(self._txtstarMaxtxt, false)
	gohelper.setActive(self._goPlayerBg, false)

	local fightParam = AbyssModel.instance:getCurFightResultParam()

	if fightParam and fightParam.activityId == AbyssModel.instance:getCurActId() and fightParam.stageId == stageInfo.stageId then
		self.isPreviousChallenged = true
	else
		self.isPreviousChallenged = false
	end

	self:refreshStarState(haveChallenge, stageInfo.star, stageInfo.totalStar)

	if haveChallenge then
		self._txtstarMaxtxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a6_abyss_stage_round_desc"), stageInfo.round)

		self:refreshHeroState(stageInfo.heroList)
	end

	if self.isPreviousChallenged == false then
		self:playAnim()
	end
end

function AbyssStageItem:refreshStarState(haveChallenge, curStar, maxStar)
	local haveStar = maxStar > 0

	gohelper.setActive(self._gostarlayout, haveStar)

	if not haveStar then
		return
	end

	tabletool.clear(self._starItemList)

	local starDic = {}

	for i = 1, maxStar do
		starDic[i] = haveChallenge and i <= curStar and 1 or 0
	end

	gohelper.CreateObjList(self, self.onStarItemCreate, starDic, nil, self._gostargroup)
end

function AbyssStageItem:onStarItemCreate(itemGo, state, index)
	local item = self:getUserDataTb_()
	local isFinish = state == 1
	local isFinal = index >= self.stageInfo.totalStar

	item.isFinal = isFinal
	item.isFinish = isFinish

	local starLocked = gohelper.findChild(itemGo, "star1")
	local starFinished = gohelper.findChild(itemGo, "star2")
	local starAnimator = gohelper.findChildComponent(starFinished, "", gohelper.Type_Animator)
	local starLocked2 = gohelper.findChild(itemGo, "star3")
	local starFinished2 = gohelper.findChild(itemGo, "star4")
	local starAnimator2 = gohelper.findChildComponent(starFinished2, "", gohelper.Type_Animator)

	gohelper.setActive(starFinished, isFinish and not isFinal)
	gohelper.setActive(starLocked, not isFinish and not isFinal)
	gohelper.setActive(starFinished2, isFinish and isFinal)
	gohelper.setActive(starLocked2, not isFinish and isFinal)

	local animator = isFinal and starAnimator2 or starAnimator

	item.animator = animator

	table.insert(self._starItemList, item)
end

function AbyssStageItem:refreshHeroState(heroList)
	gohelper.CreateObjList(self, self.onHeroItemCreate, heroList, nil, self._goherogItem, AbyssStageHeroItem)
end

function AbyssStageItem:playAnim()
	local haveChallenge = self.haveChallenge

	gohelper.setActive(self._gocurherogroup, haveChallenge)
	gohelper.setActive(self._txtstarMaxtxt, haveChallenge)
	gohelper.setActive(self._goPlayerBg, haveChallenge)

	local animName = self.isPreviousChallenged and "finish" or "idle"

	self._animator:Play(animName, 0, 0)

	for _, item in ipairs(self._starItemList) do
		if item.isFinish then
			local starAnimName = self.isPreviousChallenged and "light" or "lighted"

			logNormal("新深渊关卡 播放星星动画: " .. starAnimName)
			item.animator:Play(starAnimName, 0, 0)
		end
	end
end

function AbyssStageItem:onHeroItemCreate(item, heroId, index)
	item:setInfo(heroId)
end

function AbyssStageItem:onDestroy()
	tabletool.clear(self._starItemList)
end

return AbyssStageItem
