


## eCommerce Project - Checkout Form - Drop-Down Lists

### Angular Project - Checkout Form - Populate Credit Card Dates - Overview
![](assets/Pasted%20image%2020220918005308.png)

ng generate service services/Luv2ShopForm




### Angular Project - Checkout Form - Create Form Service

### Angular Project -Checkout Form - Retrieve Months and Years from Service
https://github.com/darbyluv2code/fullstack-angular-and-springboot/blob/master/source-code/ecommerce-project-release-2.0/18-checkout-form-populate-credit-card-dates-dropdown-list/03-frontend/angular-ecommerce/src/app/services/luv2-shop-form.service.ts

```ts
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class Luv2ShopFormService {

  constructor() { }

  getCreditCardMonths(startMonth: number): Observable<number[]> {

    let data: number[] = [];
    
    // build an array for "Month" dropdown list
    // - start at current month and loop until 

    for (let theMonth = startMonth; theMonth <= 12; theMonth++) {
      data.push(theMonth);
    }

    return of(data);
  }

  getCreditCardYears(): Observable<number[]> {

    let data: number[] = [];

    // build an array for "Year" downlist list
    // - start at current year and loop for next 10 years
    
    const startYear: number = new Date().getFullYear();
    const endYear: number = startYear + 10;

    for (let theYear = startYear; theYear <= endYear; theYear++) {
      data.push(theYear);
    }

    return of(data);
  }

}
```

checkout.component.ts
```ts
// ngOnInit

// populate credit card months

const startMonth: number = new Date().getMonth() + 1;

console.log("startMonth: " + startMonth);

this.luv2ShopFormService.getCreditCardMonths(startMonth).subscribe(

data => {

console.log("Retrieved credit card months: " + JSON.stringify(data));

this.creditCardMonths = data;

}

);

// populate credit card years

this.luv2ShopFormService.getCreditCardYears().subscribe(

data => {

console.log("Retrieved credit card years: " + JSON.stringify(data));

this.creditCardYears = data;

}

);
```

checkout.component.html
```html
                    <div class="row">
                        <div class="col-md-2"> <label>Expiration Month</label></div>
                        <div class="col-md-9">
                            <div class="input-space">
                                <select formControlName="expirationMonth">
                                    <option *ngFor="let month of creditCardMonths">
                                        {{ month }}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-2"> <label>Expiration Year</label></div>
                        <div class="col-md-9">
                            <div class="input-space">
                                <select formControlName="expirationYear">
                                    <option *ngFor="let year of creditCardYears">
                                        {{ year }}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
```

![](assets/Pasted%20image%2020220918010604.png)

### Angular Project - Checkout Form - Populate Drop-Down Lists for Months and Years

### Angular Project - Checkout Form - Dependent Fields - Overview
![](assets/Pasted%20image%2020220918010758.png)
![](assets/Pasted%20image%2020220918010816.png)

checkout.component.html
Add event

```java
                    <div class="row">
                        <div class="col-md-2"> <label>Expiration Year</label></div>
                        <div class="col-md-9">
                            <div class="input-space">
                                <select formControlName="expirationYear" (change)="handleMonthsAndYears()">
                                    <option *ngFor="let year of creditCardYears">
                                        {{ year }}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
```

```typescript
  handleMonthsAndYears() {

    const creditCardFormGroup = this.checkoutFormGroup.get('creditCard');

    const currentYear: number = new Date().getFullYear();
    const selectedYear: number = Number(creditCardFormGroup.value.expirationYear);

    // if the current year equals the selected year, then start with the current month

    let startMonth: number;

    if (currentYear === selectedYear) {
      startMonth = new Date().getMonth() + 1;
    }
    else {
      startMonth = 1;
    }

    this.luv2ShopFormService.getCreditCardMonths(startMonth).subscribe(
      data => {
        console.log("Retrieved credit card months: " + JSON.stringify(data));
        this.creditCardMonths = data;
      }
    );
  }
```

### Angular Project - Checkout Form - Dependent Fields - Write Some Code

### Angular Project - Checkout Form - Populate Countries and States - Overview
![](assets/Pasted%20image%2020220918075743.png)
![](assets/Pasted%20image%2020220918011704.png)
![](assets/Pasted%20image%2020220918011724.png)

![](assets/Pasted%20image%2020220918011822.png)


### Angular Project - Checkout Form - Populate Countries and States - Create DB
https://github.com/darbyluv2code/fullstack-angular-and-springboot/blob/master/source-code/ecommerce-project-release-2.0/20-checkout-form-populate-country-and-state-dropdown-list/01-starter-files/db-scripts/countries-and-states.sql
```sql
USE `full-stack-ecommerce`;

SET foreign_key_checks = 0;

--

-- Table structure for table `country`

--

USE `full-stack-ecommerce`;

SET foreign_key_checks = 0;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `id` smallint unsigned NOT NULL,
  `code` varchar(2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

--
-- Data for table `country`
--

INSERT INTO `country` VALUES 
```

### Angular Project - Checkout Form - Populate Countries and States - JPA Entities

```java
package com.luv2code.ecommerce.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="country")
@Getter
@Setter
public class Country {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="code")
    private String code;

    @Column(name="name")
    private String name;

    @OneToMany(mappedBy = "country")
    @JsonIgnore
    private List<State> states;

}

```

```java
package com.luv2code.ecommerce.entity;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name="state")
@Data
public class State {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="name")
    private String name;

    @ManyToOne
    @JoinColumn(name="country_id")
    private Country country;

}
```

### Angular Project - Checkout Form - Populate Countries and States - Repositories

Add @JsonIgnore to entity

https://github.com/darbyluv2code/fullstack-angular-and-springboot/blob/master/source-code/ecommerce-project-release-2.0/20-checkout-form-populate-country-and-state-dropdown-list/02-backend/spring-boot-ecommerce/src/main/java/com/luv2code/ecommerce/dao/CountryRepository.java

```java
package com.luv2code.ecommerce.dao;

import com.luv2code.ecommerce.entity.Country;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin("http://localhost:4200")
@RepositoryRestResource(collectionResourceRel = "countries", path = "countries")
public interface CountryRepository extends JpaRepository<Country, Integer> {
}
```

### Angular Project - Checkout Form - Populate Countries and States - Repositories 
![](assets/Pasted%20image%2020220918080338.png)

### Angular Project - Checkout Form - Populate Countries and States - REST Config

```java
package com.luv2code.ecommerce.config;

import com.luv2code.ecommerce.entity.Country;
import com.luv2code.ecommerce.entity.Product;
import com.luv2code.ecommerce.entity.ProductCategory;
import com.luv2code.ecommerce.entity.State;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;

import javax.persistence.EntityManager;
import javax.persistence.metamodel.EntityType;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Configuration
public class MyDataRestConfig implements RepositoryRestConfigurer {

    private EntityManager entityManager;

    @Autowired
    public MyDataRestConfig(EntityManager theEntityManager) {
        entityManager = theEntityManager;
    }


    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {

        HttpMethod[] theUnsupportedActions = {HttpMethod.PUT, HttpMethod.POST, HttpMethod.DELETE};

        // disable HTTP methods for ProductCategory: PUT, POST and DELETE
        disableHttpMethods(Product.class, config, theUnsupportedActions);
        disableHttpMethods(ProductCategory.class, config, theUnsupportedActions);
        disableHttpMethods(Country.class, config, theUnsupportedActions);
        disableHttpMethods(State.class, config, theUnsupportedActions);

        // call an internal helper method
        exposeIds(config);
    }

    private void disableHttpMethods(Class theClass, RepositoryRestConfiguration config, HttpMethod[] theUnsupportedActions) {
        config.getExposureConfiguration()
                .forDomainType(theClass)
                .withItemExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions))
                .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions));
    }

    private void exposeIds(RepositoryRestConfiguration config) {

        // expose entity ids
        //

        // - get a list of all entity classes from the entity manager
        Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();

        // - create an array of the entity types
        List<Class> entityClasses = new ArrayList<>();

        // - get the entity types for the entities
        for (EntityType tempEntityType : entities) {
            entityClasses.add(tempEntityType.getJavaType());
        }

        // - expose the entity ids for the array of entity/domain types
        Class[] domainTypes = entityClasses.toArray(new Class[0]);
        config.exposeIdsFor(domainTypes);
    }
}
```

### Angular Project - Checkout Form - Populate Countries and States - Frontend
![](assets/Pasted%20image%2020220918082506.png)

### Angular Project - Checkout Form - Populate Countries and States - Create Classes

### Angular Project - Checkout Form - Populate Countries and States - Component

### Angular Project - Checkout Form - Populate Countries and States - Event Handler

### Angular Project - Checkout Form - Populate Countries and States - States

### Angular Project - Checkout Form - Populate Countries and States - Billing

### Angular Project - Checkout Form - Populate Countries and States - Console logs

### Angular Project - Checkout Form - Populate Countries and States - Bug Fix
