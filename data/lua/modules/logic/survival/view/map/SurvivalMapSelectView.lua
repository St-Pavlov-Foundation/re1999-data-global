-- chunkname: @modules/logic/survival/view/map/SurvivalMapSelectView.lua

module("modules.logic.survival.view.map.SurvivalMapSelectView", package.seeall)

local SurvivalMapSelectView = class("SurvivalMapSelectView", SurvivalInitTeamView)

function SurvivalMapSelectView:onInitView()
	SurvivalMapSelectView.super.onInitView(self)

	self._btnnext = gohelper.findChildButtonWithAudio(self._root, "Right/#btn_next")
	self._txttitle = gohelper.findChildTextMesh(self._root, "Right/txt_title")
	self._imagePic = gohelper.findChildSingleImage(self._root, "Right/simage_pic")
	self._txtdesc = gohelper.findChildTextMesh(self._root, "Right/scroll_desc/Viewport/#go_descContent/#txt_desc")
	self._goeffectdesc = gohelper.findChild(self._root, "Right/scroll_desc/Viewport/#go_descContent/go_descitem/#txt_desc")
	self._goeasy = gohelper.findChild(self._root, "Right/#go_difficulty/easy")
	self._gonormal = gohelper.findChild(self._root, "Right/#go_difficulty/normal")
	self._gohard = gohelper.findChild(self._root, "Right/#go_difficulty/hard")
	self._gohardEffect = gohelper.findChild(self.viewGO, "#simage_bghard")
	self.BossInvasionContainer = gohelper.findChild(self._root, "Map/BossInvasionContainer")

	local resPath = self.viewContainer:getSetting().otherRes.survivalbossinvasionview
	local obj = self:getResInst(resPath, self.BossInvasionContainer)

	self.survivalBossInvasionView = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalBossInvasionView, 2)
end

function SurvivalMapSelectView:addEvents()
	self._btnnext:AddClickListener(self.onClickNext, self)
end

function SurvivalMapSelectView:removeEvents()
	self._btnnext:RemoveClickListener()
end

function SurvivalMapSelectView:onOpen()
	self._groupMo = SurvivalMapModel.instance:getInitGroup()

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	self._items = {}

	local mapUnlockCount = weekMo.clientData.data.nowUnlockMapsCount
	local isChange = false

	for index = 1, 4 do
		local mapInfo = weekMo.mapInfos[index]
		local go = gohelper.findChild(self._root, "Map/#go_map" .. index)

		self._items[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalMapSelectItem, {
			callback = self.onClickMap,
			callobj = self,
			mapInfo = mapInfo,
			index = index
		})

		if mapInfo and mapUnlockCount < index then
			self._items[index]:playUnlockAnim()

			isChange = true
		end
	end

	if isChange then
		weekMo.clientData.data.nowUnlockMapsCount = #weekMo.mapInfos

		weekMo.clientData:saveDataToServer(true)
	end

	self:onClickMap(self._groupMo.selectMapIndex + 1, true)
end

function SurvivalMapSelectView:onClickMap(index, isFirst)
	if not isFirst and self._groupMo.selectMapIndex == index - 1 then
		return
	end

	if not isFirst then
		self.viewContainer:playAnim("right_out")
		TaskDispatcher.runDelay(self._delayPlayIn, self, 0.1)
		UIBlockHelper.instance:startBlock("SurvivalMapSelectView_switch", 0.1)
	else
		self:_refreshInfo()
	end

	self._groupMo.selectMapIndex = index - 1

	for key, item in ipairs(self._items) do
		item:setIsSelect(key == index)
	end
end

function SurvivalMapSelectView:_delayPlayIn()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_switch)
	self.viewContainer:playAnim("right_in")
	self:_refreshInfo()
end

function SurvivalMapSelectView:_refreshInfo()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local mapInfo = weekMo.mapInfos[self._groupMo.selectMapIndex + 1]
	local mapCo = mapInfo.groupCo

	if not mapCo then
		logError("没有地图组配置" .. mapInfo.mapId)

		return
	end

	self._imagePic:LoadImage(ResUrl.getSurvivalMapIcon("survival_map_pic0" .. mapCo.type))

	self._txttitle.text = mapCo.name
	self._txtdesc.text = mapInfo.taskCo and mapInfo.taskCo.desc2 or ""

	local arr = string.split(mapCo.effectDesc, "|") or {}

	if mapInfo.disasterCo then
		table.insert(arr, 1, mapInfo.disasterCo.disasterDesc)
	elseif mapInfo.disasterId == 0 then
		local _, desc = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.NoDisasterDesc)

		if not string.nilorempty(desc) then
			table.insert(arr, 1, desc)
		end
	end

	if mapInfo.rainCo then
		table.insert(arr, 1, mapInfo.rainCo.rainDesc)
	end

	gohelper.setActive(self._goeasy, mapInfo.level == 1)
	gohelper.setActive(self._gonormal, mapInfo.level == 2)
	gohelper.setActive(self._gohard, mapInfo.level == 3)
	gohelper.setActive(self._gohardEffect, mapInfo.level == 3)
	gohelper.CreateObjList(self, self._createEffectDesc, arr, nil, self._goeffectdesc)
end

function SurvivalMapSelectView:_createEffectDesc(obj, data, index)
	local txt = gohelper.findChildTextMesh(obj, "")

	txt.text = data
end

function SurvivalMapSelectView:onClickNext()
	TaskDispatcher.cancelTask(self._delayPlayIn, self)
	self.viewContainer:playAnim("go_selectmember")
	self.viewContainer:nextStep()
end

function SurvivalMapSelectView:onClose()
	TaskDispatcher.cancelTask(self._delayPlayIn, self)
	SurvivalMapSelectView.super.onClose(self)
end

return SurvivalMapSelectView
