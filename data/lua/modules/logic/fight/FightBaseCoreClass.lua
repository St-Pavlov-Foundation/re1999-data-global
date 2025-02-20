module("modules.logic.fight.FightBaseCoreClass", package.seeall)

slot0 = class("FightBaseCoreClass")

function slot0.ctor(slot0, ...)
	slot0:initializationInternal(slot0.class, slot0, ...)

	return slot0:onAwake(...)
end

function slot0.onInitialization(slot0)
	slot0._instantiateClass = {}
	slot0.components_internal = {}
	slot0.USERDATA = {}
end

function slot0.onDestructor(slot0)
	slot1 = slot0.keyword_gameObject

	for slot5 = #slot0.USERDATA, 1, -1 do
		if type(slot0.USERDATA[slot5]) == "table" then
			for slot10 in pairs(slot6) do
				rawset(slot6, slot10, nil)
			end
		else
			rawset(slot0, slot6, nil)
		end
	end

	if slot0.REGISTAFTERDISPOSE then
		for slot5 = #slot0._instantiateClass, 1, -1 do
			if not slot0._instantiateClass[slot5].INVOKEDDISPOSE then
				slot6:disposeSelf()
			end
		end
	end

	for slot5, slot6 in pairs(slot0.components_internal) do
		if not slot6.INVOKEDDISPOSE then
			slot6:disposeSelf()
		end
	end

	for slot5, slot6 in pairs(slot0) do
		if type(slot6) == "userdata" then
			rawset(slot0, slot5, nil)
		end
	end

	slot0._instantiateClass = nil
	slot0.components_internal = nil
	slot0.USERDATA = nil

	if slot1 then
		gohelper.destroy(slot1)
	end
end

function slot0.onDestructorFinish(slot0)
end

function slot0.onAwake(slot0, ...)
end

function slot0.releaseSelf(slot0)
end

function slot0.registTable(slot0)
	if slot0.INVOKEDDISPOSE then
		logError("生命周期已经结束了,但是又调用注册table的方法,请检查代码,类名:" .. slot0.__cname)
	end

	slot1 = {}

	table.insert(slot0.USERDATA, slot1)

	return slot1
end

function slot0.initializationInternal(slot0, slot1, slot2, ...)
	if slot1.super then
		slot0:initializationInternal(slot3, slot2, ...)
	end

	if rawget(slot1, "onInitialization") then
		return slot4(slot2, ...)
	end
end

function slot0.registClass(slot0, slot1, ...)
	if slot0.INVOKEDDISPOSE then
		logError("生命周期已经结束了,但是又调用注册类的方法,请检查代码,类名:" .. slot0.__cname)

		slot0.REGISTAFTERDISPOSE = true
	end

	if slot0.DISPOSING then
		slot0.REGISTAFTERDISPOSE = true
	end

	slot2 = slot1.New(...)
	slot2.PARENTROOTCLASS = slot0

	table.insert(slot0._instantiateClass, slot2)

	return slot2
end

function slot0.clearDeadInstantiatedClass(slot0)
	if slot0.INVOKEDDISPOSE then
		return
	end

	if slot0.CLEARTIMER then
		return
	end

	if not slot0.com_registTimer then
		return
	end

	slot0.CLEARTIMER = slot0:com_registRepeatTimer(slot0.internalClearDeadInstantiatedClass, 1, 1)
end

function slot0.internalClearDeadInstantiatedClass(slot0)
	if slot0.INVOKEDDISPOSE then
		logError("生命周期已经结束了,但是又调用了清除已经死亡的类的方法,请检查代码,类名:" .. slot0.__cname)
	end

	slot0.CLEARTIMER = nil

	for slot4 = #slot0._instantiateClass, 1, -1 do
		if slot0._instantiateClass[slot4].INVOKEDDISPOSE then
			table.remove(slot0._instantiateClass, slot4)
		end
	end
end

function slot0.disposeSelf(slot0)
	if slot0.INVOKEDDISPOSE then
		return
	end

	slot0.INVOKEDDISPOSE = true

	if slot0.DISPOSEINDEX ~= 0 then
		if slot0.PARENTROOTCLASS and not slot0.PARENTROOTCLASS.INVOKEDDISPOSE and slot0.PARENTROOTCLASS.clearDeadInstantiatedClass then
			slot0.PARENTROOTCLASS:clearDeadInstantiatedClass()
		end

		slot1 = slot0

		while slot1 do
			if not slot1.DISPOSEINDEX then
				slot1.DISPOSEINDEX = #slot1._instantiateClass
				slot1.DISPOSING = true
				slot2 = slot1.DISPOSEINDEX
			end

			if slot2 > 0 then
				slot3 = slot1

				for slot7 = slot2, 1, -1 do
					if not slot3._instantiateClass[slot7].INVOKEDDISPOSE then
						slot3.DISPOSEINDEX = slot7
						slot1 = slot8

						break
					end
				end

				if slot3 == slot1 then
					slot3.DISPOSEINDEX = 0
				end
			else
				if slot1 == slot0 then
					break
				end

				if not slot1.INVOKEDDISPOSE then
					slot1:disposeSelf()
				end

				if slot1.PARENTROOTCLASS then
					slot1.DISPOSEINDEX = slot1.DISPOSEINDEX - 1

					if slot1.DISPOSEINDEX < 0 then
						break
					end
				end
			end
		end
	end

	slot0:releaseSelf()
	slot0:destructorInternal(slot0.class, slot0)

	return slot0:onDestructorFinish()
end

function slot0.destructorInternal(slot0, slot1, slot2)
	if rawget(slot1, "onDestructor") then
		slot3(slot2)
	end

	if slot1.super then
		return slot0:destructorInternal(slot4, slot2)
	end
end

function slot0.registComponent(slot0, slot1)
	if slot0.INVOKEDDISPOSE then
		logError("生命周期已经结束了,但是又调用了注册组件的方法,请检查代码,类名:" .. slot0.__cname)
	end

	if slot0.components_internal[slot1.__cname] then
		return slot0.components_internal[slot1.__cname]
	end

	slot2 = slot1.New()
	slot2.PARENTROOTCLASS = slot0
	slot0.components_internal[slot1.__cname] = slot2

	return slot2
end

function slot0.releaseComponent(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0.components_internal[slot1.__cname] then
		slot0.components_internal[slot2]:disposeSelf()

		slot0.components_internal[slot2] = nil
	end
end

return slot0
