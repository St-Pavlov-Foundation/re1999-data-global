module("modules.logic.gm.model.GMCommandModel", package.seeall)

slot0 = class("GMCommandModel", ListScrollModel)

function slot0.reInit(slot0)
	slot0._hasInit = nil
end

function slot0.checkInitList(slot0)
	if slot0._hasInit then
		return
	end

	slot0._hasInit = true

	slot0:setList(lua_gm_command.configList)
end

slot0.instance = slot0.New()

return slot0
