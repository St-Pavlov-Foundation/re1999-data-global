-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191InitBuildView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191InitBuildView", package.seeall)

local Act191InitBuildView = class("Act191InitBuildView", BaseView)

function Act191InitBuildView:onInitView()
	self._scrollbuild = gohelper.findChildScrollRect(self.viewGO, "#scroll_build")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191InitBuildView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
end

function Act191InitBuildView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)

	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	self.initBuildInfo = gameInfo.initBuildInfo

	self:refreshUI()
end

function Act191InitBuildView:onClose()
	local isManual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, isManual)
end

function Act191InitBuildView:onDestroyView()
	TaskDispatcher.cancelTask(self.nextStep, self)
end

function Act191InitBuildView:refreshUI()
	self.buildCoList = lua_activity191_init_build.configDict[self.actId]
	self.bagAnimList = self:getUserDataTb_()

	local selectGoParent = gohelper.findChild(self.viewGO, "#scroll_build/Viewport/Content")
	local selectGo = gohelper.findChild(self.viewGO, "#scroll_build/Viewport/Content/SelectItem")

	gohelper.CreateObjList(self, self._onInitBuildItem, self.initBuildInfo, selectGoParent, selectGo)
	gohelper.setActive(selectGo, false)

	self._scrollbuild.horizontalNormalizedPosition = 0

	if self.extraBuildIndex and not GuideModel.instance:isGuideFinish(31504) then
		local path = "UIRoot/POPUP_TOP/Act191InitBuildView/#scroll_build/Viewport/Content/" .. self.extraBuildIndex

		GuideModel.instance:setNextStepGOPath(31504, 1, path)
		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31504)
	end
end

function Act191InitBuildView:_onInitBuildItem(go, info, i)
	local buildCo = lua_activity191_init_build.configDict[self.actId][info.id]
	local txtName = gohelper.findChildText(go, "name/txt_name")

	txtName.text = buildCo.name or ""

	local txtCoin = gohelper.findChildText(go, "Coin/txt_Coin")

	txtCoin.text = info.coin

	if not self.extraBuildIndex and info.coin ~= buildCo.coin then
		self.extraBuildIndex = i
	end

	local coinEffect = gohelper.findChild(go, "Coin/effect")

	gohelper.setActive(coinEffect, info.coin ~= buildCo.coin)

	local btnBuy = gohelper.findChildButtonWithAudio(go, "btn_select")

	self:addClickCb(btnBuy, self.selectInitBuild, self, i)

	local heroGo = gohelper.findChild(go, "hero/heroitem")
	local collectionGo = gohelper.findChild(go, "collection/collectionitem")

	for _, v in ipairs(info.detail) do
		if not self.extraBuildIndex and v.type == Activity191Enum.InitBuildType.Extra then
			self.extraBuildIndex = i
		end

		local extra = v.type == Activity191Enum.InitBuildType.Extra

		for _, id in ipairs(v.addHero) do
			self:addHero(heroGo, id, extra)
		end

		for _, id in ipairs(v.addItem) do
			self:addCollection(collectionGo, id, extra)
		end
	end

	gohelper.setActive(heroGo, false)
	gohelper.setActive(collectionGo, false)

	self.bagAnimList[i] = go:GetComponent(gohelper.Type_Animator)
end

function Act191InitBuildView:addHero(go, id, extra)
	local cloneGo = gohelper.cloneInPlace(go)
	local headGo = self:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, cloneGo)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(headGo, Act191HeroHeadItem)

	item:setData(nil, id)
	item:setPreview()
	item:setExtraEffect(extra)
end

function Act191InitBuildView:addCollection(go, itemId, extra)
	local cloneGo = gohelper.cloneInPlace(go)
	local co = Activity191Config.instance:getCollectionCo(itemId)
	local imageRare = gohelper.findChildImage(cloneGo, "rare")

	UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_propitembg_" .. co.rare)

	local collectionIcon = gohelper.findChildSingleImage(cloneGo, "collectionicon")

	collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(co.icon))

	local btnClick = gohelper.findChildButtonWithAudio(cloneGo, "collectionicon")

	self:addClickCb(btnClick, self.clickCollection, self, itemId)

	local extraEffect = gohelper.findChild(cloneGo, "effect")

	gohelper.setActive(extraEffect, extra)
end

function Act191InitBuildView:selectInitBuild(index)
	if self.selectIndex then
		return
	end

	local buildInfo = self.initBuildInfo[index]

	Activity191Rpc.instance:sendSelect191InitBuildRequest(self.actId, buildInfo.id, self.buildReply, self)

	self.selectIndex = index
end

function Act191InitBuildView:buildReply(cmd, resultCode)
	if resultCode == 0 then
		local index = self.selectIndex

		if index and self.bagAnimList[index] then
			self.bagAnimList[index]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(self.nextStep, self, 0.67)

		local gameUid = Activity191Helper.getPlayerPrefs(self.actId, "Act191GameCostTime", 0)

		Activity191Helper.setPlayerPrefs(self.actId, "Act191GameCostTime", gameUid + 1)
	end
end

function Act191InitBuildView:clickCollection(itemId)
	local param = {
		itemId = itemId
	}

	Activity191Controller.instance:openCollectionTipView(param)
end

function Act191InitBuildView:nextStep()
	self.selectIndex = nil

	Activity191Controller.instance:nextStep()
	ViewMgr.instance:closeView(self.viewName)
end

return Act191InitBuildView
