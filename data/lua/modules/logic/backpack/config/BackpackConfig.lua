module("modules.logic.backpack.config.BackpackConfig", package.seeall)

slot0 = class("BackpackConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._tabConfig = nil
	slot0._subclassConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"backpack",
		"subclass_priority"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "backpack" then
		slot0._tabConfig = slot2
	elseif slot1 == "subclass_priority" then
		slot0._subclassConfig = slot2
	end
end

function slot0.getCategoryCO(slot0)
	return slot0._tabConfig.configDict
end

function slot0.getSubclassCo(slot0)
	return slot0._subclassConfig.configDict
end

slot0.instance = slot0.New()

return slot0
