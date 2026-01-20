-- chunkname: @modules/logic/survival/view/map/comp/SurvivalMapSelectItem.lua

module("modules.logic.survival.view.map.comp.SurvivalMapSelectItem", package.seeall)

local SurvivalMapSelectItem = class("SurvivalMapSelectItem", LuaCompBase)

function SurvivalMapSelectItem:ctor(params)
	self._callback = params.callback
	self._callobj = params.callobj
	self._mapInfo = params.mapInfo
	self._index = params.index
end

function SurvivalMapSelectItem:init(go)
	self._anim = gohelper.findChildAnim(go, "")
	self._goinfo = gohelper.findChild(go, "info")
	self._txtname = gohelper.findChildTextMesh(go, "info/namebg/txt_map")
	self._goselect = gohelper.findChild(go, "info/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "info/#btn_click")
	self._simageBg = gohelper.findChildSingleImage(go, "#simage_bg")
	self._gohard = gohelper.findChild(go, "#simage_bghard")
	self._simageIcon = gohelper.findChildSingleImage(go, "info/#simage_icon")
	self._goempty = gohelper.findChild(go, "empty")

	self:_refreshView()
end

function SurvivalMapSelectItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
end

function SurvivalMapSelectItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function SurvivalMapSelectItem:_refreshView()
	gohelper.setActive(self._goempty, not self._mapInfo)
	gohelper.setActive(self._goinfo, self._mapInfo)

	if self._mapInfo then
		self._txtname.text = GameUtil.setFirstStrSize(self._mapInfo.groupCo.name, 56)

		self._simageBg:LoadImage(ResUrl.getSurvivalMapIcon(string.format("survival_map_newblock_%d_%d", self._index, self._mapInfo.level)))
		self._simageIcon:LoadImage(ResUrl.getSurvivalMapIcon("survival_map_block0" .. self._mapInfo.groupCo.type))
		gohelper.setActive(self._gohard, self._mapInfo.level == 3)
	else
		self._simageBg:LoadImage(ResUrl.getSurvivalMapIcon(string.format("survival_map_newblock_%d_%d", self._index, 0)))
		gohelper.setActive(self._gohard, false)
	end
end

function SurvivalMapSelectItem:playUnlockAnim()
	self._anim:Play("unlock", 0, 0)
end

function SurvivalMapSelectItem:_onClick()
	if not self._mapInfo then
		return
	end

	self._callback(self._callobj, self._index)
end

function SurvivalMapSelectItem:setIsSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

return SurvivalMapSelectItem
