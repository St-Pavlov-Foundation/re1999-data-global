-- chunkname: @modules/logic/versionactivity2_3/act174/view/info/Act174RoleInfo.lua

module("modules.logic.versionactivity2_3.act174.view.info.Act174RoleInfo", package.seeall)

local Act174RoleInfo = class("Act174RoleInfo", BaseView)

function Act174RoleInfo:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174RoleInfo:addEvents()
	return
end

function Act174RoleInfo:removeEvents()
	return
end

function Act174RoleInfo:onClickModalMask()
	self:closeThis()
end

function Act174RoleInfo:_editableInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
end

function Act174RoleInfo:onUpdateParam()
	return
end

function Act174RoleInfo:onOpen()
	if self.viewParam then
		local pos = self.viewParam.pos or Vector2.New(0, 0)

		recthelper.setAnchor(self.goRoot.transform, pos.x, pos.y)

		local roleCo = Activity174Config.instance:getRoleCo(self.viewParam.roleId)

		if not self.characterItem then
			self.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.goRoot, Act174CharacterInfo, self)
		end

		self.characterItem:setData(roleCo, self.viewParam.itemId)
	end
end

function Act174RoleInfo:onClose()
	return
end

function Act174RoleInfo:onDestroyView()
	return
end

return Act174RoleInfo
