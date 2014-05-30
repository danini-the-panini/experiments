#include <unordered_map>
#include <typeindex>

struct Component {};

struct PositionComponent : public Component
{
  int m_x;
  int m_y;
  int m_rotation;
};

struct VelocityComponent : public Component
{
  int m_vX;
  int m_vY;
  int m_vAngular;
};

struct RenderableComponent : public Component
{
  Sprite m_view;
};

template <typename... Ts>
struct Node
{
  

private:
};


Node<PositionComponent, VelocityComponent> MoveNode;

Node<RenderableComponent, PositionComponent> RenderNode;

struct Entity
{
  template <typename T>
  T* getComponent()
  {
    return dynamic_cast<T*>(components[typeid(T)]);
  }

  template <typename T>
  void addComponent(T* component)
  {
    components[typeid(T)] = component;
  }
private:
  typedef std::unordered_map<std::type_index, Component*> Components;
  Components components;
}