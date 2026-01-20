-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonItemDescModeSwitcher.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonItemDescModeSwitcher", package.seeall)

local Rouge2_CommonItemDescModeSwitcher = class("Rouge2_CommonItemDescModeSwitcher", LuaCompBase)

function Rouge2_CommonItemDescModeSwitcher.Load(go, dataFlag)
	if string.nilorempty(dataFlag) or gohelper.isNil(go) then
		logError("Rouge2_CommonItemDescModeSwitcher.Get error  dataFlag or go is nil")

		return
	end

	local loader = PrefabInstantiate.Create(go)

	loader:startLoad(Rouge2_Enum.ResPath.ItemDescModeSwitcher, Rouge2_CommonItemDescModeSwitcher._loadPrefabCallback, dataFlag)
end

function Rouge2_CommonItemDescModeSwitcher._loadPrefabCallback(dataFlag, loader)
	local goSwitcher = loader:getInstGO()

	MonoHelper.addNoUpdateLuaComOnceToGo(goSwitcher, Rouge2_CommonItemDescModeSwitcher, dataFlag)
end

function Rouge2_CommonItemDescModeSwitcher:ctor(dataFlag)
	self._dataFlag = dataFlag
end

function Rouge2_CommonItemDescModeSwitcher:init(go)
	self.go = go
	self._btnDetail = gohelper.findChildButtonWithAudio(self.go, "#btn_details")
	self._goSelect = gohelper.findChild(self.go, "#btn_details/circle/#go_select")

	self:refresh()
end

function Rouge2_CommonItemDescModeSwitcher:addEventListeners()
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
end

function Rouge2_CommonItemDescModeSwitcher:removeEventListeners()
	self._btnDetail:RemoveClickListener()
end

function Rouge2_CommonItemDescModeSwitcher:_btnDetailOnClick()
	local targetDescMode = self._curDescMode == Rouge2_Enum.ItemDescMode.Simply and Rouge2_Enum.ItemDescMode.Full or Rouge2_Enum.ItemDescMode.Simply

	Rouge2_BackpackController.instance:switchItemDescMode(self._dataFlag, targetDescMode)
	self:refresh()
end

function Rouge2_CommonItemDescModeSwitcher:refresh()
	self._curDescMode = Rouge2_BackpackController.instance:getItemDescMode(self._dataFlag)

	gohelper.setActive(self._goSelect, self._curDescMode == Rouge2_Enum.ItemDescMode.Full)
end

return Rouge2_CommonItemDescModeSwitcher
