---
layout: post
title: "객체지향 vs 함수형"
description: "frontend 면접 대비 컴퓨터 기초"
comments: true
category: computerScience
---

# OOP

인간 중심적 프로그래밍 패러다임이라고 할 수 있습니다.

즉, 현실 세계를 프로그래밍으로 옮겨와 프로그래밍하는 것을 말합니다.

현실 세계의 사물들을 객체라고 보고 그 객체로부터 개발하고자 하는 애플리케이션에 필요한 특징들을 뽑아와 프로그래밍 하는 것입니다.

- 상속

  클래스개념에서 상위 클래스(부모)로 부터 하위 클래스(자식)이 유산을 물려받는 것과 같이, `부모의 메소드나 변수를 사용`할 수 있는 것

- 다형성

  같은 함수가 있다고 가정할 때 그 `함수가 매개 변수에 따라 다른 역할`을 할 수 있음

- 캡슐화

  보통 데이터를 `은닉`시킨다고 표현하는데, 외부에서 쉽게 데이터를 접근할 수 없게 만들기도하고, 데이터 구조와 데이터를 다루는 방법들을 한데다 묶는 것.

- 추상화

  공통적인 속성이나 기능을 묶어서 이름을 붙이는 것 ( a b d 이런게있다고 치면 이런건 알파벳이라고 묶을 수 있다)

<br/>

## 객체지향 설계 원칙 종류

1. SRP(Single Responsibility Principle)

   단일 책임 원칙클래스는 단 하나의 책임을 가져야 하며 클래스를 변경하는 이유는 단 하나의 이유이어야 합니다.

2. OCP(Open-Closed Principle)

   개방-폐쇄 원칙. 기존의 코드를 변경하지 않으면서 기능을 추가할 수 있어야함

3. LSP(Liskov Substitution Principle)

   리스코프 치환 원칙. 상위 타입의 객체를 하위 타입의 객체로 치환해도 상위 타입을 사용하는 프로그램은 정상적으로 동작해야 합니다.

4. ISP(Interface Segregation Principle)

   인터페이스 분리 원칙. 인터페이스는 그 인터페이스를 사용하는 클라이언트를 기준으로 분리해야 합니다.

5. DIP(Dependency Inversion Principle)

   의존 역전 원칙. 고수준 모듈은 저수준 모듈의 구현에 의존해서는 안됩니다.

<br/><br/>

# Functional

함수형 프로그래밍은 순수함수와 보조 함수의 조합을 통해 로직내에 존재하는 조건문과 반복문을 제거하여 복잡성을 해결하고 변수의 사용을 억제하여 상태 변경을 피하려는 프로그래밍 패러다임이다.

- 여기서 순수함수란 ?

  순수함수는 같은 입력이 주어지면, 같은 출력을 반환해야하고, side effect(부작용) 이 없어야한다.

  결국, 함수형 프로그래밍은 순수함수를 통해 sideeffect를 최대한 억제하여 오류를 피하고 프로그램의 안정성을 높이려는 노력의 한 방법

<br/><br/>

---

## 둘의 차이점

객체지향은 객체 안에 상태를 저장하고, 이 상태를 이용해서 메소드를 추가하고 상태변화를 설정하고 조정하기위해 다양한 기능을 사용한다. 이에 반해 함수형 프로그래밍은 상태를 제어하는것보다 상태를 저장하지 않고 없애는데 주력한다.

예를들면, 객체 지향은 상태를 저장하는 필드와 그 필드들을 이용해 기능을 제공하는 메소드를 만들고 클래스를 만듭니다. 반면 함수형은 몇몇 자료구조(list, map, set) 등을 이용해 최적화된 동작을 만들어낸다.
